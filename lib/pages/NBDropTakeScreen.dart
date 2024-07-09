import 'package:flutter/material.dart';
import 'package:flutter_app/pages/frame_10.dart';
import 'package:flutter_app/pages/frame_11.dart';
import 'package:flutter_app/pages/frame_12.dart';
import 'package:flutter_app/pages/frame_13.dart';
import 'package:flutter_app/pages/frame_14.dart';
import 'package:flutter_app/pages/frame_15.dart';
import 'package:flutter_app/pages/frame_16.dart';
import 'package:flutter_app/pages/frame_17.dart';
import 'package:flutter_app/pages/frame_18.dart';
import 'package:flutter_app/pages/frame_7.dart';
import 'package:flutter_app/pages/frame_9.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/pages/frame_8.dart';
import 'package:flutter_app/utils/NBWidgets.dart';

class NBDropTakeScreen extends StatelessWidget {
  final String day;
  final String userId; // Kullanıcı kimliği parametresi

  NBDropTakeScreen({required this.day, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nbAppBarWidget(context, title: 'Ders İptal/Seçim'),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: ListView(
          children: [
            Text(
              'Derslerinizi iptal edebilir ya da değiştirebilirsiniz. Gelmediğiniz derslerin telafisi maalesef mümkün değildir. Sistemin kurallarından dışarıya çıkmak yasaktır.',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Color(0xFF000000),
              ),
            ),
        
            SizedBox(height: 28),
            buildDayGroup(context, 'Pazartesi, Perşembe', [
            buildTimeGroup(context, '09:00 Grubu', Frame7()),
            buildTimeGroup(context, '10:00 Grubu', Frame8()),
            buildTimeGroup(context, '11:00 Grubu', Frame9()),
            buildTimeGroup(context, '12:00 Grubu', Frame10()),
            buildTimeGroup(context, '13:00 Grubu', Frame11()),
            buildTimeGroup(context, '14:00 Grubu', Frame12()),
            buildTimeGroup(context, '17:00 Grubu', Frame13()),
            buildTimeGroup(context, '18:00 Grubu', Frame14()),
            buildTimeGroup(context, '19:00 Grubu', Frame15()),
            buildTimeGroup(context, '20:00 Grubu', Frame16()),
            buildTimeGroup(context, '21:00 Grubu', Frame17()),
            buildTimeGroup(context, '22:00 Grubu', Frame18()),
            ]),
            buildDayGroup(context, 'Salı, Cuma', [
            buildTimeGroup(context, '09:00 Grubu', Frame7()),
            buildTimeGroup(context, '10:00 Grubu', Frame8()),
            buildTimeGroup(context, '11:00 Grubu', Frame9()),
            buildTimeGroup(context, '12:00 Grubu', Frame10()),
            buildTimeGroup(context, '13:00 Grubu', Frame11()),
            buildTimeGroup(context, '14:00 Grubu', Frame12()),
            buildTimeGroup(context, '17:00 Grubu', Frame13()),
            buildTimeGroup(context, '18:00 Grubu', Frame14()),
            buildTimeGroup(context, '19:00 Grubu', Frame15()),
            buildTimeGroup(context, '20:00 Grubu', Frame16()),
            buildTimeGroup(context, '21:00 Grubu', Frame17()),
            buildTimeGroup(context, '22:00 Grubu', Frame18()),
            ]),
            
            buildDayGroup(context, 'Çarşamba', [
            buildTimeGroup(context, '09:00 Grubu', Frame7()),
            buildTimeGroup(context, '10:00 Grubu', Frame8()),
            buildTimeGroup(context, '11:00 Grubu', Frame9()),
            buildTimeGroup(context, '12:00 Grubu', Frame10()),
            buildTimeGroup(context, '13:00 Grubu', Frame11()),
            buildTimeGroup(context, '14:00 Grubu', Frame12()),
            buildTimeGroup(context, '17:00 Grubu', Frame13()),
            buildTimeGroup(context, '18:00 Grubu', Frame14()),
            buildTimeGroup(context, '19:00 Grubu', Frame15()),
            buildTimeGroup(context, '20:00 Grubu', Frame16()),
            buildTimeGroup(context, '21:00 Grubu', Frame17()),
            buildTimeGroup(context, '22:00 Grubu', Frame18()),
            ]),
           
            buildDayGroup(context, 'Perşembe', [
            buildTimeGroup(context, '09:00 Grubu', Frame7()),
            buildTimeGroup(context, '10:00 Grubu', Frame8()),
            buildTimeGroup(context, '11:00 Grubu', Frame9()),
            buildTimeGroup(context, '12:00 Grubu', Frame10()),
            buildTimeGroup(context, '13:00 Grubu', Frame11()),
            buildTimeGroup(context, '14:00 Grubu', Frame12()),
            buildTimeGroup(context, '17:00 Grubu', Frame13()),
            buildTimeGroup(context, '18:00 Grubu', Frame14()),
            buildTimeGroup(context, '19:00 Grubu', Frame15()),
            buildTimeGroup(context, '20:00 Grubu', Frame16()),
            buildTimeGroup(context, '21:00 Grubu', Frame17()),
            buildTimeGroup(context, '22:00 Grubu', Frame18()),
            ]),
            buildDayGroup(context, 'Cuma', [
            buildTimeGroup(context, '09:00 Grubu', Frame7()),
            buildTimeGroup(context, '10:00 Grubu', Frame8()),
            buildTimeGroup(context, '11:00 Grubu', Frame9()),
            buildTimeGroup(context, '12:00 Grubu', Frame10()),
            buildTimeGroup(context, '13:00 Grubu', Frame11()),
            buildTimeGroup(context, '14:00 Grubu', Frame12()),
            buildTimeGroup(context, '17:00 Grubu', Frame13()),
            buildTimeGroup(context, '18:00 Grubu', Frame14()),
            buildTimeGroup(context, '19:00 Grubu', Frame15()),
            buildTimeGroup(context, '20:00 Grubu', Frame16()),
            buildTimeGroup(context, '21:00 Grubu', Frame17()),
            buildTimeGroup(context, '22:00 Grubu', Frame18()),
            ]),
           
          ]
        ),
      ),
    );
  }

  Widget buildDayGroup(BuildContext context, String text, List<Widget> timeGroups) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            text,
            style: GoogleFonts.getFont(
              'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF000000),
            ),
          ),
        ),
        Column(
          children: timeGroups.map((timeGroup) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: timeGroup,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildTimeGroup(BuildContext context, String text, Widget targetFrame) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetFrame),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFEFA4A4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
