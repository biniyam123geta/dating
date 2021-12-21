import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dating/data/db/remote/response.dart';
import 'package:dating/data/provider/user_provider.dart';
import 'package:dating/ui/screens/top_navigation_screen.dart';
import 'package:dating/ui/widgets/bordered_text_field.dart';
import 'package:dating/ui/widgets/custom_modal_progress_hud.dart';
import 'package:dating/ui/widgets/rounded_button.dart';
import 'package:dating/ui/widgets/beautyTextfield.dart';
import 'package:dating/util/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _inputEmail = '';
  String _inputPassword = '';
  bool _isLoading = false;
  UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of(context, listen: false);
  }

  void loginPressed() async {
    setState(() {
      _isLoading = true;
    });
    await _userProvider
        .loginUser(_inputEmail, _inputPassword, _scaffoldKey)
        .then((response) {
      if (response is Success<UserCredential>) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(TopNavigationScreen.id, (route) => false);
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: CustomModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Padding(
            padding: kDefaultPadding,
            child: Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login to your account',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: 40),
              new Theme(
                data: new ThemeData(
                  primaryColor: Colors.redAccent,
                  primaryColorDark: Colors.red,
                ),
                child:TextField(
                  style: TextStyle(color:Colors.black),
                  decoration: new InputDecoration(
                    labelText: "Enter Email",
                    hintText: "Enter here...",
                    hintStyle: TextStyle(color:Colors.black),
                    fillColor: Colors.black,
                    border: new OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: new BorderRadius.circular(25.0),

                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),

                    ),

                    prefixIcon: const Icon(
                      Icons.mark_email_read_sharp,
                      color: Colors.green,
                    ),),

                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => _inputEmail = value,
                  )),

                  SizedBox(height: 10),
                  new Theme(
                      data: new ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child:TextField(
                        obscureText: true,
                        style: TextStyle(color:Colors.black),
                        decoration: new InputDecoration(
                          labelText: "Enter password",
                          hintText: "Enter here...",
                          hintStyle: TextStyle(color:Colors.black),
                          fillColor: Colors.black,
                          border: new OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: new BorderRadius.circular(25.0),

                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink, width: 2.0),

                          ),

                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.green,
                          ),),

                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => _inputPassword = value,
                      )),
                  Expanded(child: Container()),
                  RoundedButton(text: 'LOGIN', onPressed: () => loginPressed())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
