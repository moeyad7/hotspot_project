// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

import '../buttons/signInButtonCustom.dart';
import '../textfields/textFormFieldCustom.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    String dateOfBirth,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  AuthForm(this.submitFn, this.isLoading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  TextEditingController dateOfBirth = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  String _userReEnterPassword = '';
  String _userDateOfBirth = '';

  bool _isLogin = true;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      if (!_isLogin) {
        if (_userPassword.trim() == _userReEnterPassword.trim()) {
          widget.submitFn(
            _userEmail.trim(),
            _userPassword.trim(),
            _userName.trim(),
            _userDateOfBirth,
            _isLogin,
            context,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Passwords do not match!'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      } else {
        widget.submitFn(
          _userEmail.trim(),
          _userPassword.trim(),
          _userName.trim(),
          _userDateOfBirth,
          _isLogin,
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    signInWithGoogle() async {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        final String url =
            'https://firebasestorage.googleapis.com/v0/b/hotspot-project-41fbb.appspot.com/o/Defaults%2Fempty_profile.jpg?alt=media&token=afc8fb64-94c4-406f-bb50-03dcb86ffe83';

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          "username": userCredential.user!.displayName,
          "email": userCredential.user!.email,
          "dateOfBirth": DateFormat('dd/MM/yyyy').format(DateTime.now()),
          'image_url': url,
          'ratings': [],
          'comments': [],
          'saved': [],
          'visited': [],
          'recent_searches': [],
        });
      }
    }

    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/Logo.png',
                height: 200,
                width: 200,
              ),
              Text(
                'Welcome to H🔥tspot',
                style: TextStyle(fontSize: 35),
              ),
              SizedBox(height: 20),
              CustomSlidingSegmentedControl(
                initialValue: 1,
                children: {
                  1: Text(
                    'Sign In',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  2: Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    _isLogin = value == 1 ? true : false;
                  });
                },
                decoration: BoxDecoration(
                  color: Color(0xFFF58A07).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                thumbDecoration: BoxDecoration(
                  color: Color(0xFFF58A07),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SignInButtonCustom(
                      button: Buttons.Google,
                      signIn: () {
                        signInWithGoogle();
                      },
                    ),
                    SizedBox(height: 10),
                    TexFormFieldCustom(
                      label: 'Email',
                      valid: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      save: (value) {
                        _userEmail = value;
                      },
                    ),
                    SizedBox(height: 10),
                    if (!_isLogin)
                      TexFormFieldCustom(
                        label: 'Username',
                        valid: (value) {
                          if (value!.isEmpty || value.length < 3) {
                            return 'Please enter a username.';
                          }
                          return null;
                        },
                        save: (value) {
                          _userName = value;
                        },
                      ),
                    SizedBox(height: 10),
                    TexFormFieldCustom(
                      label: 'Password',
                      valid: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 characters long.';
                        }
                        return null;
                      },
                      save: (value) {
                        _userPassword = value;
                      },
                      obscure: true,
                    ),
                    SizedBox(height: 10),
                    if (!_isLogin)
                      TexFormFieldCustom(
                        label: 'Re-enter Password',
                        valid: (value) {
                          if (value!.isEmpty || value.length < 7) {
                            return 'Password must be at least 7 characters long.';
                          }
                          return null;
                        },
                        save: (value) {
                          _userReEnterPassword = value;
                        },
                        obscure: true,
                      ),
                    SizedBox(height: 10),
                    if (!_isLogin)
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a date of birth.';
                          }
                          return null;
                        },
                        controller: dateOfBirth,
                        decoration: InputDecoration(
                          labelText: "Date of birth",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF58A07).withOpacity(0.3),
                        ),
                        onTap: () async {
                          DateTime date = DateTime(1900);
                          FocusScope.of(context).requestFocus(new FocusNode());

                          date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Color(0xFFF58A07),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          ) as DateTime;

                          dateOfBirth.text =
                              DateFormat('dd/MM/yyyy').format(date);
                        },
                        onSaved: (value) {
                          _userDateOfBirth = value!;
                        },
                      )
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (widget.isLoading) CircularProgressIndicator(),
              if (!widget.isLoading)
                ElevatedButton(
                  child: Text(
                    _isLogin ? 'Sign In' : 'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    _trySubmit();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF58A07),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              TextButton(
                child: Text(
                  'continue as a guest',
                  style: TextStyle(
                    color: Color(0xFF228CE5),
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/HomePage');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
