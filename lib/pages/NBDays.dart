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
        title: Text('Ders İptal/Seçim'),
        backgroundColor: Color(0xFFFFFFFF),
      ),
      body: Center(
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
    );
  }
}

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
        title: Text('Ders İptal/Seçim'),
        backgroundColor: Color(0xFFFFFFFF),
      ),
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