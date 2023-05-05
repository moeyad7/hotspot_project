import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInButtonCustom extends StatelessWidget {
  final Buttons button;
  final Function signIn;
  const SignInButtonCustom({
    required this.button,
    required this.signIn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      child: SignInButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        button,
        onPressed: signIn,
      ),
    );
  }
}