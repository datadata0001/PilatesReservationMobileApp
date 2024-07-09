import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class NBRemainingClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 33),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 58),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '“Kullanıcın Adı Soyadı” Hoşgeldiniz',
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFFEFA4A4),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(7, 0, 0, 29),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEFA4A4),
                ),
                child: Container(
                  width: 95,
                  padding: EdgeInsets.fromLTRB(0.4, 0, 0, 1),
                  child: Text(
                    'Çıkış',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(1, 0, 0, 22),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEFA4A4),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(9, 7, 9, 14),
                  child: Text(
                    '      Ders iptal\Seçim',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(1, 0, 0, 22),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEFA4A4),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(14, 9, 14.3, 12),
                  child: Text(
                    '   Kalan Ders Saati\Ücret',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(1, 0, 0, 22),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEFA4A4),
                ),
                child: Container(
                  width: 167,
                  padding: EdgeInsets.fromLTRB(0, 11, 32.6, 10),
                  child: Text(
                    'Kullanıcı Bilgileri',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(1, 0, 0, 22),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEFA4A4),
                ),
                child: Container(
                  width: 167,
                  height: 36,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEFA4A4),
                ),
                child: Container(
                  width: 167,
                  height: 36,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}