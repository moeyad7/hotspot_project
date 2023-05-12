
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../compnents/forms/auth_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/AuthScreen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String userName,
    String dateOfBirth,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final String url =
            'https://firebasestorage.googleapis.com/v0/b/hotspot-project-41fbb.appspot.com/o/Defaults%2Fempty_profile.jpg?alt=media&token=afc8fb64-94c4-406f-bb50-03dcb86ffe83';

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': userName,
          'email': email,
          'dateOfBirth': dateOfBirth,
          'image_url': url,
          'ratings': {
            "location": {
              "rating": 0,
              "locationId": 0,
            }
          },
          'comments': {
            "location": {
              "comment": "",
              "locationId": 0,
            }
          },
          'saved': {
            "locationId": 0,
          },
          'visited': {
            "locationId": 0,
          },
          'recent_searches': [],
        });
      }
      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message as String;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message,
                    style: TextStyle(color: Colors.black),
        ),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),
      );
      print(err);
    } catch (err) {
      var message = 'An error occurred, please check your credentials!';

      message = err.toString().split(']')[1].trim();

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message,
          style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),
        
      );
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF1ED),
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
