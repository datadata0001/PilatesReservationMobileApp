import 'package:flutter/material.dart';
import 'package:flutter_app/pages/NBReformerScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class NBDropTakeScreen extends StatelessWidget {
  final String day;
  final String userId;

  NBDropTakeScreen({required this.day, required this.userId});

  List<Widget> buildTimeGroups(BuildContext context, String day) {
    List<String> times = [
      '08:00:00',
      '09:00:00',
      '10:00:00',
      '11:00:00',
      '12:00:00',
      '13:00:00',
      '14:00:00',
      '17:00:00',
      '18:00:00',
      '19:00:00',
      '20:00:00',
      '21:00:00',
      '22:00:00',
    ];
    List<Widget> timeGroups = [];
    for (var time in times) {
      timeGroups.add(
        buildTimeGroup(
          context,
          '${time.split(':')[0]}:00 Grubu',
          NBReformerScreen(reformers: List.filled(6, null), day: day, time: time),
        ),
      );
    }
    return timeGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ders İptal/Seçim', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFEFA4A4),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFA4A4), Color(0xFFFFFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: ListView(
          children: [
            SizedBox(height: 28),
            ...buildTimeGroups(context, day), // Dinamik olarak zaman gruplarını oluştur
          ],
        ),
      ),
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
          gradient: LinearGradient(
            colors: [Color(0xFFEFA4A4), Color(0xFFEFA4A4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
