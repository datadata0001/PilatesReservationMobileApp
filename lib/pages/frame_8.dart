import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/modelgen/reformers.g.dart';
import 'package:flutter_app/pages/NBProfileScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Frame8 extends StatefulWidget {
  @override
  _Frame8State createState() => _Frame8State();
}

class _Frame8State extends State<Frame8> {
  final _client = Supabase.instance.client;
  List<Reformers> reformers = [];
  User? user;

  @override
  void initState() {
    super.initState();
    _fetchReformers();
    fetchUser();
  }

  Future<void> fetchUser() async {
    user = supabase.auth.currentUser;
    if (user == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
    setState(() {});
  }
  
  Future<void> _fetchReformers() async {
    final response = await _client.from('reformers').select().gte("id", 1).lte("id",6);
    if (response == null) {
      setState(() {
        for (var i = 0; i < response.length; i++) {
          reformers[i] = (response[i]['name'] as Reformers?)!;
        }
      });
    }
  }


  Future<void> _updateReformer(int index, String? userId) async {
    final response = await _client
        .from('reformers')
        .update({'ogrenci_id': userId, 'status': userId != null})
        .eq('id', reformers[index].id)
        ;
    if (response.error == null) {
      setState(() {
        reformers[index].ogrenciId = userId as int?;
        reformers[index].status = userId != null;
      });
    }
  }

  Future<void> _sendNotification(String message) async {
    // Bildirim gönderme kodunu burada ekleyin
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ders İptal/Seçim'),
        backgroundColor: Color(0xFFEFA4A4),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          children: [
            Text(
              'Reformer Seçimi',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Color(0xFFEFA4A4),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2,
                ),
                itemCount: reformers.length,
                itemBuilder: (context, index) {
                  return _buildReformerCard(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReformerCard(int index) {
    final reformer = reformers[index];
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEFA4A4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              reformer.name ?? 'Boş',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            if (reformer.ogrenciId != null)
              Column(
                children: [
                  Text(
                    'Sahip: ${reformer.ogrenciId}',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: () async {
                      await _updateReformer(index, null);
                      await _sendNotification('Rezervasyon iptal edildi: ${reformer.name}');
                    },
                    child: Text(
                      'İptal Et',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  if (user != null) {
                    await _updateReformer(index, user!.email);
                    await _sendNotification('Yeni rezervasyon: ${reformer.name}');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Lütfen önce giriş yapın.'),
                      ),
                    );
                  }
                },
                child: Text(
                  'Rezerve Et',
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
