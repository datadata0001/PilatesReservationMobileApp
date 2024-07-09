import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Text('Ders İptal/Seçim'),
        backgroundColor: Color(0xFFFFFFFF),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var day in ['Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma', 'Cumartesi', 'Pazar'])
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
    );
  }
}
