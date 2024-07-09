import 'package:flutter/material.dart';
import 'package:flutter_app/utils/NBWidgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NBChangePasswordScreen extends StatefulWidget {
  @override
  _NBChangePasswordScreenState createState() => _NBChangePasswordScreenState();
}

class _NBChangePasswordScreenState extends State<NBChangePasswordScreen> {
  TextEditingController oldPassCont = TextEditingController();
  TextEditingController newPassCont = TextEditingController();
  TextEditingController confirmPassCont = TextEditingController();

  FocusNode oldPassFocus = FocusNode();
  FocusNode newPassFocus = FocusNode();
  FocusNode confirmPassFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: nbAppBarWidget(context, title: 'Change Password'),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              nbAppTextFieldWidget(
                oldPassCont,
                'Old Password',
                TextFieldType.PASSWORD,
                focus: oldPassFocus,
                nextFocus: newPassFocus,
              ),
              16.height,
              nbAppTextFieldWidget(
                newPassCont,
                'New Password',
                TextFieldType.PASSWORD,
                focus: newPassFocus,
                nextFocus: confirmPassFocus,
              ),
              16.height,
              nbAppTextFieldWidget(confirmPassCont, 'Repeat New Password', TextFieldType.PASSWORD, focus: confirmPassFocus),
              16.height,
              nbAppButtonWidget(
                context,
                'Continue',
                () async {
                  if (newPassCont.text != confirmPassCont.text) {
                    toast('New passwords do not match');
                    return;
                  }

                  if (oldPassCont.text.isEmpty || newPassCont.text.isEmpty || confirmPassCont.text.isEmpty) {
                    toast('All fields are required');
                    return;
                  }

                  try {
                    final response = await Supabase.instance.client.auth.updateUser(UserAttributes(password: newPassCont.text));

                    if (response != null) {
                      toast('Password change failed: ${response}');
                    } else {
                      toast('Password Changed Successfully');
                      finish(context);
                    }
                  } catch (e) {
                    toast('Password is changing $e');
                  }
                },
              ),
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
