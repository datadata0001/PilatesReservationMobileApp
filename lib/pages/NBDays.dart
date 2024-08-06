import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/pages/NBReformerScreen.dart';
import 'NBDropTakeScreen.dart'; // NBDropTakeScreen sayfasını içe aktar

class NBDays extends StatelessWidget {
  final String userId; // Kullanıcı kimliği

  NBDays({required this.userId});

  void navigateToNBDropTakeScreen(BuildContext context, String day) {
    // NBDropTakeScreen'e yönlendirme
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NBDropTakeScreen(day: day, userId: userId),
      ),
    );
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
          colors: [Color(0xFFFDEBEB), Color(0xFFEFA4A4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var day in ['Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma'])
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEFA4A4),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => navigateToNBDropTakeScreen(context, day),
                      child: Text(
                        day,
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
