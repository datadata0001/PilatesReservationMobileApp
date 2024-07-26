import 'package:flutter/material.dart';
import 'package:flutter_app/component/NBAllHomeComponents.dart';
import 'package:flutter_app/component/NBHomeComponents.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model.dart';
import 'package:flutter_app/modelgen/reformers.g.dart';
import 'package:flutter_app/modelgen/users.g.dart';
import 'package:flutter_app/pages/NBProfileScreen.dart';
import 'package:flutter_app/utils/NBDataProviders.dart';
import 'package:flutter_app/utils/NBImages.dart';
import 'package:google_fonts/google_fonts.dart';
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
  List<Reformers> mReformersList = [];
  List<Users> mUsersList = [];

  String userName = "";

  @override
  void initState() {
    super.initState();
    mDrawerList = nbGetDrawerItems(widget.userId);
    init();
    fetchUserProfile();
  }

  Future<void> init() async {
    try {
      List<Reformers> fetchedReformers = await nbGetReformersDetails();
      print('Fetched Reformers: $fetchedReformers'); // Verilerin doğru alınıp alınmadığını kontrol et
      fetchedReformers.sort((a,b) => a.id.compareTo(b.id));
      setState(() {
        mReformersList = fetchedReformers;
      });
    } catch (e) {
      print('Error fetching reformers: $e');
    }
    try {
      List<Users> fetchedUsers = await nbGetUserDetails();
      print('Fetched Users: $fetchedUsers'); // Verilerin doğru alınıp alınmadığını kontrol et
      fetchedUsers.sort((a,b) => a.userId.compareTo(b.userId));
      setState(() {
        mUsersList = fetchedUsers;
      });
    } catch (e) {
      print('Error fetching reformers: $e');
    }    

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
  return Scaffold(
    key: _scaffoldKey,
    appBar: AppBar(
      title: Text('Ana Sayfa'),
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
                userName.isEmpty ? 'Profil Görüntüle' : userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
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
              'Kullanıcı Bilgileri',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 16),
            mReformersList.isEmpty || mUsersList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : _buildUserDetailsCard(0),
          ],
        ),
      ),
    ),
  );
}

Widget _buildUserDetailsCard(int index) {
  final user = mUsersList[index];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfoRow('Ad', user.firstName),
              _buildUserInfoRow('Soyad', user.lastName),
              _buildUserInfoRow('Email', user.email),
              _buildUserInfoRow('Kalan Ders Saati', user.classHours.toString()),
            ],
          ),
        ),
      ),
      SizedBox(height: 16),
      Text(
        'Kullanıcının Rezerve Ettiği Reformerlar',
        style: GoogleFonts.getFont(
          'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF333333),
        ),
      ),
      SizedBox(height: 8),
      _buildReformerReservations(user.userId),
    ],
  );
}

Widget _buildUserInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF333333),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.getFont(
              'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xFF666666),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildReformerReservations(int userId) {
  final userReformers = mReformersList.where((r) => r.userId == userId).toList();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: userReformers.map((reformer) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfoRow('Gün', reformer.daygroup ?? 'Belirtilmemiş'),
              _buildUserInfoRow('Saat', reformer.timegroup ?? 'Belirtilmemiş'),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

}