import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/NBImages.dart';
import 'package:flutter_app/utils/NBWidgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NBEditProfileScreen extends StatefulWidget {
  static String tag = '/NBEditProfileScreen';

  @override
  NBEditProfileScreenState createState() => NBEditProfileScreenState();
}

class NBEditProfileScreenState extends State<NBEditProfileScreen> {
  TextEditingController userNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  FocusNode userNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  late File imageFile;
  bool loadFromFile = false;

  Future getImage(ImageSource source) async {
    var image = await ImagePicker().getImage(source: source);
    setState(() {
      if (image != null) {
        imageFile = File(image.path);
        loadFromFile = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final response = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      if (response == null) {
        final data = response;
        setState(() {
          userNameCont.text = data['username'] ?? '';
          emailCont.text = user.email ?? '';
        });
      }
    }
  }

  Future<void> updateProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final updates = {
        'id': user.id,
        'username': userNameCont.text,
      };

      final response = await Supabase.instance.client
          .from('profiles')
          .upsert(updates)
          .eq('id', user.id);

      if (response.error == null) {
        toast('Profile updated Successfully');
      } else {
        toast('Error updating profile: ${response.error!.message}');
      }

      if (emailCont.text.isNotEmpty) {
        final authResponse = await Supabase.instance.client.auth.updateUser(
          UserAttributes(email: emailCont.text),
        );
        if (authResponse != null) {
          toast('Error updating email: ${authResponse}');
        }
      }

      if (passwordCont.text.isNotEmpty) {
        final authResponse = await Supabase.instance.client.auth.updateUser(
          UserAttributes(password: passwordCont.text),
        );
        if (authResponse != null) {
          toast('Error updating password: ${authResponse}');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nbAppBarWidget(context, title: 'Edit Profile'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: loadFromFile
                  ? Image.file(imageFile, fit: BoxFit.cover, width: 100, height: 100).cornerRadiusWithClipRRect(50)
                  : Image.asset(NBProfileImage, fit: BoxFit.cover, width: 100, height: 100).cornerRadiusWithClipRRect(50),
            ).onTap(() {
              getImage(ImageSource.gallery);
            }),
            8.height,
            Text('Upload Image', style: boldTextStyle()),
            16.height,
            nbAppTextFieldWidget(
              userNameCont,
              'Edit Username',
              TextFieldType.OTHER,
              focus: userNameFocus,
              nextFocus: emailFocus,
            ),
            16.height,
            nbAppTextFieldWidget(emailCont, 'Change Email', TextFieldType.EMAIL, focus: emailFocus, nextFocus: passwordFocus),
            16.height,
            nbAppTextFieldWidget(passwordCont, 'Change Password', TextFieldType.PASSWORD, focus: passwordFocus),
            16.height,
            nbAppButtonWidget(
              context,
              'Save',
              () {
                updateProfile();
                finish(context);
              },
            )
          ],
        ).paddingAll(16),
      ),
    );
  }
}
