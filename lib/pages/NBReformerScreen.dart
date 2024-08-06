import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/modelgen/reformers.g.dart';
import 'package:flutter_app/modelgen/users.g.dart';
import 'package:flutter_app/pages/NBProfileScreen.dart';
import 'package:flutter_app/utils/NBDataProviders.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  List<Reformers> mReformersList = [];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    fetchUser();
    setStartIndex();
    fetchReformers();
    setupListener();
    setupListener2();

    //setupSubscriber();
    initializeNotifications();

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
  
  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
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

  Future<void> fetchReformers() async {
    try {
      List<Reformers> fetchedReformers = await nbGetReformersDetails();
      print('Fetched Reformers: $fetchedReformers'); // Verilerin doğru alınıp alınmadığını kontrol et
      fetchedReformers.sort((a,b) => a.id.compareTo(b.id));
      setState(() {
        mReformersList = fetchedReformers
            .where((reformer)=>
                reformer.daygroup == widget.day && reformer.timegroup == widget.time)
            .toList();
      });
    } catch (e) {
      print('Error fetching reformers: $e');
    }
  }
  

  Future<void> _updateReformer(int index, String? user ) async {
    if(user == null){
      //iptal etme durumu (reformer'i müsait hale getirme)
      final response = await _client
      .from("reformers")
      .update({
        "name":"Reformer",
        "status":false,
        "user_id":null,
      })
      .eq("id", startIndex+index+1)
      .eq("daygroup", widget.day);
/*
    if(response.error != null){
      print("Error updating reformer: ${response.error!.message}");
      return;
    }
*/
    setState((){
      widget.reformers[startIndex + index] = Reformers(
        name:"Reformer",
        id: startIndex + index + 1, 
        status: false, 
        userId: null);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Text("Reformer başarıyla iptal edildi."),
     ),
    );
    _showNotification("Reformer İptal Edildi", "Reformer başarıyla iptal edildi.");

    }else {
  //rezervasyon durumu (reformeri rezerve etme)
  final userResponse = await _client
    .from("users")
    .select("user_id, first_name")
    .single();
/*
  if (userResponse == null) {
    print('Error fetching user: ${userResponse}');
    return;
  }
*/
  final int userId = userResponse['user_id'];
  final String firstName = userResponse["first_name"]; 
  
  final response = await _client
    .from('reformers')
    .update({
      'name': firstName,
      "status": true,
      "user_id": userId
    })
    .eq('id', startIndex + index + 1)
    .eq('daygroup', widget.day); 
  /*
  if (response.error != null) {
    print('Error updating reformer: ${response.error!.message}');
    return;
    
  }
*/
  setState(() {
    widget.reformers[startIndex + index] = Reformers(
      name: firstName,
      status: true,
      userId: userId, 
      id: startIndex + index + 1, 
    );
  });
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Reformer başarıyla rezerve edildi."),
    ),
  );
  }
  await fetchReformers();

}

void setupListener() {
    _client
      .from("reformers")
      .stream(primaryKey: ["id"])
      .eq('daygroup', widget.day)
      .listen((List<Map<String, dynamic>> data) {
        print("Listen the data ${data.toString()}");
      });
  }

  
void setupListener2() {
    _client
      .from("reformers")
      .stream(primaryKey: ["id"])
      .eq('timegroup', widget.time)
      .listen((List<Map<String, dynamic>> data) {
        print("Listen the data ${data.toString()}");
      });
  }
/*
void setupSubscriber(){
  _client
    .channel("reformers")
    .onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema:"reformers", 
      callback: (payload){
        print("Change reveiced: ${payload.toString()}");
      })
    .subscribe();
    
}
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ders İptal/Seçim',style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFEFA4A4),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDEBEB), Color(0xFFEFA4A4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
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
              child: widget.reformers.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: mReformersList.length, // Örneğin, her zaman 6 öğe gösterileceğini varsayıyoruz
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
    final reformer = mReformersList[index];
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
            Column(
              children: [
                Text(
                  'Reformer: ${reformer?.name}',
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Sahip: ${reformer?.userId ?? 'Boş'}',
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                if (reformer.userId != null) 
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 144, 0, 32),
                    ),
                    onPressed: () => _updateReformer(index,null),
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
                if (reformer?.userId == null) 
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
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
                        color: Color(0xFFEFA4A4),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


