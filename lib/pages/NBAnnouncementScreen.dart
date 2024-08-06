import 'package:flutter/material.dart';
import 'package:flutter_app/component/NBAnnouncementComponent.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model.dart';
import 'package:flutter_app/modelgen/duyuru.g.dart';
import 'package:flutter_app/pages/NBProfileScreen.dart';
import 'package:flutter_app/utils/NBDataProviders.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:flutter_app/utils/NBImages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class NBAnnouncementScreen extends StatefulWidget {
  static String tag = '/NBAnnouncementScreen';
  final String userId;

  const NBAnnouncementScreen({super.key, required this.userId});

  @override
  NBAnnouncementScreenState createState() => NBAnnouncementScreenState();
}

class NBAnnouncementScreenState extends State<NBAnnouncementScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Duyuru> mAnnouncementList;
  late List<NBDrawerItemModel> mDrawerList;

  @override
  void initState() {
    super.initState();
    mAnnouncementList = []; // Başlangıçta boş bir liste oluşturuldu
    init();
    mDrawerList = nbGetDrawerItems(widget.userId);
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
        title: Text('Duyurular', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFEFA4A4),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFEFA4A4), Color(0xFFFDEBEB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Duyurularımız',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 16),
            mAnnouncementList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: mAnnouncementList.length,
                      itemBuilder: (context, index) {
                        final announcement = mAnnouncementList[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              announcement.title ?? 'No Title',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF333333),
                              ),
                            ),
                            subtitle: Text(
                              announcement.content ?? 'No Content',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Color(0xFF666666),
                              ),
                            ),
                            trailing: Text(
                              announcement.createdAt?.toString() ?? 'No Date',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Color(0xFF999999),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
