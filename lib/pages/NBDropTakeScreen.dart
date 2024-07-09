import 'package:flutter/material.dart';
import 'package:flutter_app/pages/NBReformerScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/utils/NBWidgets.dart';

class NBDropTakeScreen extends StatelessWidget {
  final String day;
  final String userId;

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
