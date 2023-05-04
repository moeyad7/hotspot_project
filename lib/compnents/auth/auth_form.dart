import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          child: Column(
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
              Center(
                child: SwitchListTile(
                  value: _isLogin,
                  onChanged: (value) {
                    setState(() {
                      _isLogin = value;
                    });
                  },
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
