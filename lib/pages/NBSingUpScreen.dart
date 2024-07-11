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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
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
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;

    final response = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user == null) {
      toast('Sign up error: ${response}');
    } else {
      toast('Sign up successful');
      final insertResponse = await Supabase.instance.client.from('users').insert({
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'email': email,
      });


      if (insertResponse.error != null) {
        toast('Error saving user info: ${insertResponse.error?.message}');
      } else {
        toast('User info saved successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NBHomeScreen(userId: response.user!.id)),
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

    if (accessToken == null || idToken == null) {
      throw 'No Access Token or ID Token found.';
    }

    final response = await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    if (response.user == null) {
      toast('Google Sign-In error: ${response}');
    } else {
      final profile = googleUser;
      final insertResponse = await Supabase.instance.client.from('users').insert({
        'first_name': profile!,
        'last_name': profile,
        'phone': '',  // Google sign-in does not provide phone number
        'email': profile.email,
      });

      if (insertResponse.error != null) {
        toast('Error saving user info: ${insertResponse.error?.message}');
      } else {
        toast('Google Sign-In successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NBHomeScreen(userId: response.user!.id)),
        );
      }
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
            nbAppTextFieldWidget(firstNameController, 'First Name', TextFieldType.NAME, focus: firstNameFocus, nextFocus: lastNameFocus),
            16.height,
            nbAppTextFieldWidget(lastNameController, 'Last Name', TextFieldType.NAME, focus: lastNameFocus, nextFocus: emailFocus),
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
