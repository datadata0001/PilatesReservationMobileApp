import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/NBForgotPasswordScreen.dart';
import 'package:flutter_app/pages/NBHomeScreen.dart';
import 'package:flutter_app/pages/NBSingUpScreen.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:flutter_app/utils/NBImages.dart';
import 'package:flutter_app/utils/NBWidgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


const webClientId = 'my-web.apps.googleusercontent.com';
const iosClientId = 'my-ios.apps.googleusercontent.com';

class NBSignInScreen extends StatefulWidget {
  static String tag = '/NBSignInScreen';

  @override
  NBSignInScreenState createState() => NBSignInScreenState();
}

class NBSignInScreenState extends State<NBSignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    
  }

  Future<void> loginSupabase() async {
      final AuthResponse res = await supabase.auth.signInWithPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    final Session? session = res.session;
    final User? user = res.user;
    if (user == null)
    {
      print("Giriş başarısız!");
    }
    else{
      print("Giriş başarılı!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NBHomeScreen(userId: '',)),/// userId kontrol et
      );
    }
  }


  Future<void> _nativeGoogleSignIn() async {
    const webClientId = 'my-web.apps.googleusercontent.com';
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    final accessToken = googleAuth?.accessToken;
    final idToken = googleAuth?.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    final response = await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    

    if (response.user == null) {
      print('Google Sign-In error: ${response}');
    } else {
      print('Google Sign-In successful');
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NBHomeScreen(userId:" ",)),
      );
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            100.height,
            Text('\nPilatesStudio Uygulamasına Hoşgeldiniz!', style: boldTextStyle(size: 30)),
            30.height,
            nbAppTextFieldWidget(
              emailController,
              'Email Adresiniz',
              TextFieldType.EMAIL,
              focus: emailFocus,
              nextFocus: passwordFocus,
            ),
            16.height,
            nbAppTextFieldWidget(passwordController, 'Şifre', TextFieldType.PASSWORD, focus: passwordFocus),
            16.height,
            Align(
              alignment: Alignment.centerRight,
              child: Text('Şifremi Unuttum?', style: boldTextStyle(color: NBPrimaryColor)).onTap(
                () {
                  NBForgotPasswordScreen().launch(context);
                },
              ),
            ),
            16.height,
            nbAppButtonWidget(
              context,
              'Giriş Yap',
              () {
                //NBHomeScreen().launch(context);
                loginSupabase();
              },
            ),
            30.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hesabınız yok mu?', style: primaryTextStyle()),
                Text(' Kayıt Ol', style: boldTextStyle(color: NBPrimaryColor)).onTap(
                  () {
                    NBSingUpScreen().launch(context);
                  },
                ),
              ],
            ),
            50.height,
            Row(
              children: [
                Divider(thickness: 2).expand(),
                8.width,
                Text('Ya da bunlarla giriş yap', style: secondaryTextStyle()),
                8.width,
                Divider(thickness: 2).expand(),
              ],
            ),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  child: Row(
                    children: [
                      Image.asset(NBFacebookLogo, width: 20, height: 20),
                      8.width,
                      Text('Facebook', style: primaryTextStyle(color: white)),
                    ],
                  ),
                  onTap: () {},
                  width: (context.width() - (3 * 16)) * 0.5,
                  color: NBFacebookColor,
                  elevation: 0,
                ).cornerRadiusWithClipRRect(20),
                16.width,
                AppButton(
                  child: Row(
                    
                    children: [
                      
                      Image.asset(NBGoogleLogo, width: 20, height: 20),
                      8.width,
                      Text('Google', style: primaryTextStyle(color: black)),
                      
                    ],
                  ),
                  onTap: () async{
                    await _nativeGoogleSignIn();
                    NBHomeScreen(userId: '',).launch(context);
                  },
                  width: (context.width() - (3 * 16)) * 0.5,
                  elevation: 0,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(width: 1, color: grey),
                  ),
                ),
              ],
            ),
          ],
        ).paddingOnly(left: 16, right: 16),
      ),
    );
  }
}
