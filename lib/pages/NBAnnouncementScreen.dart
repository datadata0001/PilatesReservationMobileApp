import 'package:flutter/material.dart';
import 'package:flutter_app/component/NBAnnouncementComponent.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/modelgen/duyuru.g.dart';
import 'package:flutter_app/utils/NBDataProviders.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:flutter_app/utils/NBImages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class NBAnnouncementScreen extends StatefulWidget {
  static String tag = '/NBAnnouncementScreen';

  @override
  NBAnnouncementScreenState createState() => NBAnnouncementScreenState();
}

class NBAnnouncementScreenState extends State<NBAnnouncementScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Duyuru> mAnnouncementList;

  @override
  void initState() {
    super.initState();
    mAnnouncementList = []; // Başlangıçta boş bir liste oluşturuldu
    init();
  }

  Future<void> init() async {
    try {
      mAnnouncementList = await nbGetAnnouncementDetails();
      setState(() {}); // State'i güncellemek için setState kullanılmalı
    } catch (e) {
      print('Error fetching announcements: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Duyurular'),
        backgroundColor: Color(0xFFEFA4A4),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
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
                title: Text(
                  'Profil Görüntüle',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Profil ekranını başlat
                },
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  // Menü öğeleri buraya eklenebilir
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDEBEB), Color(0xFFEFA4A4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Duyurular',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xFF333333),
                ),
              ),
              SizedBox(height: 16),
              mAnnouncementList.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : NBAnnouncementComponent(list: mAnnouncementList),
            ],
          ),
        ),
      ),
    );
  }
}
