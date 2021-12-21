import 'package:flutter/material.dart';
import 'package:dating/util/constants.dart';
import 'package:dating/ui/widgets/app_image_with_text.dart';
import 'package:dating/ui/widgets/rounded_button.dart';
import 'package:dating/ui/widgets/rounded_outlined_button.dart';
import 'package:dating/ui/screens/login_screen.dart';
import 'package:dating/ui/screens/register_screen.dart';

class StartScreen extends StatelessWidget {
  static const String id = 'start_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: kDefaultPadding,
          child: Container(
            margin: EdgeInsets.only(bottom: 40, top: 120),
            child: Column(
              children: [
                AppIconTitle(),
                Expanded(child: Container()),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Virtually meet thousands of like-minded singles and connect at lightning speed. '
                      'Chat into the wee hours of the night if youd like.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                SizedBox(height: 60),
                RoundedButton(
                    text: 'CREATE ACCOUNT',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, RegisterScreen.id);
                    }),
                SizedBox(height: 20),
                RoundedOutlinedButton(
                  text: 'LOGIN',
                  onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
