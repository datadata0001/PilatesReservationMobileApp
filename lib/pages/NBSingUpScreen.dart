import 'package:flutter/material.dart';
import 'package:flutter_app/pages/NBHomeScreen.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:flutter_app/utils/NBWidgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nb_utils/nb_utils.dart';



class NBSingUpScreen extends StatefulWidget {
  static String tag = '/NBSingUpScreen';

  @override
  NBSingUpScreenState createState() => NBSingUpScreenState();
}

class NBSingUpScreenState extends State<NBSingUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  Future<void> signUp() async {
    final email = emailController.text;
    final password = passwordController.text;
    final phone = phoneController.text;
    final name = nameController.text;

    final response = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user == null) {
      toast('Sign up error: ${response}');
    } else {
      toast('Sign up successful');
      // Save additional user info to the 'profiles' table
      final insertResponse = await Supabase.instance.client.from('profiles').insert({
        'id': response.user!.id,
        'name': name,
        'email': email,
        'phone': phone,
      });

    if (response.user == null) {
      print('Google Sign-In error: ${response}');
    } else {
      print('Google Sign-In successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NBHomeScreen(userId: '',)),
      );
      
    }
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
      toast('Google Sign-In error: ${response}');
    } else {
      toast('Google Sign-In successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NBHomeScreen(userId: '',)),
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
            Text('Create new\naccount', style: boldTextStyle(size: 30)),
            30.height,
            nbAppTextFieldWidget(nameController, 'Name', TextFieldType.NAME, focus: nameFocus, nextFocus: emailFocus),
            16.height,
            nbAppTextFieldWidget(emailController, 'Email Address', TextFieldType.EMAIL, focus: emailFocus, nextFocus: phoneFocus),
            16.height,
            nbAppTextFieldWidget(phoneController, 'Phone Number', TextFieldType.PHONE, focus: phoneFocus, nextFocus: passwordFocus),
            16.height,
            nbAppTextFieldWidget(passwordController, 'Password', TextFieldType.PASSWORD, focus: passwordFocus),
            50.height,
            nbAppButtonWidget(context, 'Create Account', () async {
              await signUp();
            }),
            16.height,
            nbAppButtonWidget(context, 'Sign In with Google', () async {
              await _nativeGoogleSignIn();
            }),
            30.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Have an Account?', style: primaryTextStyle()),
                Text(' Sign In', style: boldTextStyle(color: NBPrimaryColor)).onTap(
                  () {
                    finish(context);
                  },
                ),
              ],
            ),
          ],
        ).paddingOnly(left: 16, right: 16),
      ),
    );
  }
}
