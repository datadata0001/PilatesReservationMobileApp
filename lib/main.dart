import 'package:flutter/material.dart';
import 'package:flutter_app/pages/NBHomeScreen.dart';
import 'package:flutter_app/pages/NBSignInScreen.dart';
import 'package:flutter_app/pages/NBSingUpScreen.dart';
import 'package:flutter_app/pages/NBSplashScreen.dart';

import 'package:flutter_app/pages/frame_10.dart';
import 'package:flutter_app/pages/frame_11.dart';
import 'package:flutter_app/pages/frame_12.dart';
import 'package:flutter_app/pages/frame_13.dart';
import 'package:flutter_app/pages/frame_14.dart';
import 'package:flutter_app/pages/frame_15.dart';
import 'package:flutter_app/pages/NBRemainingClass.dart';
import 'package:flutter_app/pages/NBDropTakeScreen.dart';
import 'package:flutter_app/pages/frame_7.dart';
import 'package:flutter_app/pages/frame_8.dart';
import 'package:flutter_app/pages/frame_9.dart';
import 'package:flutter_app/pages/template_login_pages_1.dart';
import 'package:flutter_app/store/AppStore.dart';
import 'package:flutter_app/utils/AppTheme.dart';
import 'package:flutter_app/utils/NBDataProviders.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

AppStore appStore = AppStore();

void main() async {

    await Supabase.initialize(
    url: 'https://vebxkfxercbzhirfbfba.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZlYnhrZnhlcmNiemhpcmZiZmJhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc2Nzc3NTAsImV4cCI6MjAzMzI1Mzc1MH0.NJdIj14fFwiRcfcULg12oVTuNG_ndHRBKKKKW1vJx8Y',
  );

  WidgetsFlutterBinding.ensureInitialized();
  
  await initialize(aLocaleLanguageList: languageList());


  appStore.toggleDarkMode(value: getBoolAsync('isDarkModeOnPref'));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(const MyApp());
} //client eklemen lazım buraya sürekli initialize etmene lüzüm yoktur.
final supabase = Supabase.instance.client; //client yapısı

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '${'Pilates Studio'}${!isMobile ? ' ${platformName()}' : ''}',
        home: NBSplashScreen(),
        theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localeResolutionCallback: (locale, supportedLocales) => locale,
      ),
      
    );
  }
}
