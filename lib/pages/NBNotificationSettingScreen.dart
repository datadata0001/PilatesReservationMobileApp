import 'package:flutter/material.dart';
import 'package:flutter_app/utils/NBWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:nb_utils/nb_utils.dart';

// FlutterLocalNotificationsPlugin örneği oluşturun
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class NBNotificationSettingScreen extends StatefulWidget {
  static String tag = '/NBNotificationSettingScreen';

  @override
  NBNotificationSettingScreenState createState() => NBNotificationSettingScreenState();
}

class NBNotificationSettingScreenState extends State<NBNotificationSettingScreen> {
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
  }

  Future<void> _loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    });
  }

  Future<void> _updateNotificationSettings(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = value;
      prefs.setBool('notifications_enabled', value);
    });
    if (value) {
      await initializeNotifications(); // Bildirimleri etkinleştirin
    }
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nbAppBarWidget(context, title: 'Bildirim Ayarları'),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: Text('Bildirimler', style: primaryTextStyle()),
            value: _notificationsEnabled,
            onChanged: (bool value) async {
              await _updateNotificationSettings(value);
              // Bildirimleri devre dışı bırakmak uygulama düzeyinde yapılabilir,
              // ancak cihazın sistem ayarlarında bildirimlerin tamamen kapatılması gerekebilir.
            },
            activeColor: NBPrimaryColor,
          ),
        ],
      ),
    );
  }
}
