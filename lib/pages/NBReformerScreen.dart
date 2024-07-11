import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/modelgen/reformers.g.dart';
import 'package:flutter_app/modelgen/users.g.dart';
import 'package:flutter_app/pages/NBProfileScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:postgres/messages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NBReformerScreen extends StatefulWidget {
  final List<Reformers?> reformers;
  final String day;
  final String time;

  const NBReformerScreen({Key? key, required this.reformers, required this.day, required this.time}) : super(key: key);

  @override
  _NBReformerScreenState createState() => _NBReformerScreenState();
}

class _NBReformerScreenState extends State<NBReformerScreen> {
  final _client = Supabase.instance.client;
  User? user;
  int startIndex = 0;
  

  @override
  void initState() {
    super.initState();
    fetchUser();
    setStartIndex();
  }

  void setStartIndex() {
    int dayOffset;

    // Gün değerine göre başlangıç indeksi
    switch (widget.day) {
      case 'Pazartesi':
        dayOffset = 0;
        break;
      case 'Salı':
        dayOffset = 78;
        break;
      case 'Çarşamba':
        dayOffset = 156;
        break;
      case 'Perşembe':
        dayOffset = 234;
        break;
      case 'Cuma':
        dayOffset = 312;
        break;
      default:
        dayOffset = 0;
    }

    int timeOffset;
    switch (widget.time) {
      case "08:00:00":
        timeOffset = 0;
        break;
      case "09:00:00":
        timeOffset = 6;
        break;
      case "10:00:00":
        timeOffset = 12;
        break;
      case "11:00:00":
        timeOffset = 18;
        break;
      case "12:00:00":
        timeOffset = 24;
        break;
      case "13:00:00":
        timeOffset = 30;
        break;
      case "14:00:00":
        timeOffset = 36;
        break;
      case "17:00:00":
        timeOffset = 42;
        break;
      case "18:00:00":
        timeOffset = 48;
        break;
      case "19:00:00":
        timeOffset = 54;
        break;
      case "20:00:00":
        timeOffset = 60;
        break;
      case "21:00:00":
        timeOffset = 66;
        break;
      case "22:00:00":
        timeOffset = 72;
        break;
      default:
        timeOffset = 0;
    }

    startIndex = dayOffset + timeOffset;
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

  Future<void> _updateReformer(int index, String? user ) async {

  final userResponse = await _client
    .from("users")
    .select("user_id")
    .single();

  final int userId = userResponse['user_id'];

    final response = await _client
        .from('reformers')
        .update({
          'name': user,
          "status":true,
          "user_id":userId
        })
        .eq('id', startIndex + index + 1)
        .eq('daygroup', widget.day);
    if (response.error == null) {
      setState(() {
        widget.reformers[startIndex + index] = user as Reformers?;
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
                itemCount: widget.reformers.length,
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
    final reformerUser = widget.reformers[index];
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
            if (reformerUser?.status == true)
              Column(
                children: [
                  Text(
                    'Sahip: ${reformerUser?.name}',
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
