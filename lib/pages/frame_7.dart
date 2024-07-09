import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/modelgen/reformers.g.dart';
import 'package:flutter_app/pages/NBProfileScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Frame7 extends StatefulWidget {
  @override
  _Frame7State createState() => _Frame7State();
}

class _Frame7State extends State<Frame7> {
  final _client = Supabase.instance.client;
  List<Reformers?> reformers = List.filled(18, null);
  User? user;
  int currentPage = 0;
  final int reformersPerPage = 6; // Her sayfada gösterilecek reformer sayısı



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
    final response = await _client.from('reformers').select().range(currentPage * reformersPerPage, (currentPage + 1) * reformersPerPage - 1);
    if (response == null) {
      setState(() {
        for (var i = 0; i < response.length; i++) {
          reformers[i] = response[i]['name'] as Reformers?;
        }
      });
    }
  }

  Future<void> _updateReformer(int index, String? user) async {
    final response = await _client
        .from('reformers')
        .update({'name': user})
        .eq('id', index + 1 + currentPage * reformersPerPage);
    if (response.error == null) {
      setState(() {
        reformers[index] = user as Reformers?;
      });
    }
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
    final reformerUser = reformers[index];
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
              reformerUser?.name ?? 'Boş',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            if (reformerUser != null)
              Column(
                children: [
                  Text(
                    'Sahip: $reformerUser',
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
                    onPressed: () => _updateReformer(index, null),
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
                onPressed: () {
                  if (user != null) {
                    _updateReformer(index, user!.email);
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
