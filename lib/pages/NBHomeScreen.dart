import 'package:flutter/material.dart';
import 'package:flutter_app/component/NBAllHomeComponents.dart';
import 'package:flutter_app/component/NBHomeComponents.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model.dart';
import 'package:flutter_app/modelgen/reformers.g.dart';
import 'package:flutter_app/pages/NBProfileScreen.dart';
import 'package:flutter_app/utils/NBDataProviders.dart';
import 'package:flutter_app/utils/NBImages.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NBHomeScreen extends StatefulWidget {
  static String tag = '/NBHomeScreen';
  final String userId;

  const NBHomeScreen({super.key, required this.userId});


  @override
  NBHomeScreenState createState() => NBHomeScreenState();
}

class NBHomeScreenState extends State<NBHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late List<NBDrawerItemModel> mDrawerList;
  List<Reformers> mNewsList = [];
  List<Reformers> mTechNewsList = [], mFashionNewsList = [], mSportsNewsList = [], mScienceNewsList = [];

  String userName = "";

  @override
  void initState() {
    super.initState();
    mDrawerList = nbGetDrawerItems(widget.userId);
    init();
    fetchUserProfile();
  }

  Future<void> init() async {
    // Haber detaylarını getir
    mNewsList = await nbGetReformersDetails();

    // Supabase'den kullanıcı profilini getir
    await fetchUserProfile();

    // Haberleri kategorilere ayır
    mNewsList.forEach((element) {
      if (element.name == 'Technology') {
        mTechNewsList.add(element);
      } else if (element.id == 'Fashion') {
        mFashionNewsList.add(element);
      } else if (element.daygroup == 'Sports') {
        mSportsNewsList.add(element);
      } else if (element.timegroup == 'Science') {
        mScienceNewsList.add(element);
      }
    });

    setState(() {}); // Durum güncellemesi
  }

  Future<void> fetchUserProfile() async {
    try {
      final supabase = await Supabase.instance.client;

      if (supabase.auth.currentUser != null) {
        setState(() {
          userName = supabase.auth.currentUser?.email ?? "";
        });
      }
    } catch (e) {
      print('Beklenmeyen bir hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Tab sayısı
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Text('Pilates Studio'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'XXX'),
              Tab(text: 'XXX'),
              Tab(text: 'XXX'),
              Tab(text: 'XXX'),
              Tab(text: 'XXX'),
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(NBProfileImage),
                  ),
                  title: Text(userName.isEmpty ? 'View Profile' : userName),
                  onTap: () {
                    Navigator.pop(context);
                    NBProfileScreen().launch(context);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: mDrawerList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(mDrawerList[index].title),
                      onTap: () {
                        Navigator.pop(context);
                        mDrawerList[index].widget.launch(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NBAllNewsComponent(list: mNewsList),
            NBNewsComponent(list: mTechNewsList),
            NBNewsComponent(list: mFashionNewsList),
            NBNewsComponent(list: mSportsNewsList),
            NBNewsComponent(list: mScienceNewsList),
            
            // Tab contentleri buraya eklenecek
          ],
        ),
      ),
    );
  }
}
