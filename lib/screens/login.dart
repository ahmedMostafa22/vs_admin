import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vs_admin/constants.dart';
import 'package:vs_admin/widgets/app_raised_btn.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email = '';

  String _password = '';

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.secColor,
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.only(left: 32, right: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 8.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter your email' : null,
                    onChanged: (val) {
                      _email = val.trim();
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter your email',
                        labelStyle: TextStyle(color: Colors.white70),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70))),
                    cursorColor: Colors.white70,
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white70),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70))),
                    cursorColor: Colors.white70,
                    style: TextStyle(color: Colors.white70),
                    validator: (val) => val.length < 6
                        ? 'password should be at least 6 characters'
                        : null,
                    onChanged: (val) {
                      _password = val.trim();
                    },
                  ),
                  SizedBox(height: 8),
                  AppRaisedButton(
                      txt: 'Login',
                      function: () {
                        if (validate() && _email == 'admin@admin.com')
                          try {
                            FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: _email, password: _password);
                          } catch (e) {
                            Constants.showToast(
                                'Invalid / Unauthorized email', true);
                          }
                        else
                          Constants.showToast(
                              'Invalid / Unauthorized email', false);
                      }),
                  SizedBox(height: 8)
                ],
              ),
            ),
          ),
        ));
  }

  bool validate() {
    return _formkey.currentState.validate();
  }
}
