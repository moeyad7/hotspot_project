import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

AppBar MyAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      'H🔥tspot',
      textAlign: TextAlign.left,
      style: TextStyle(
        foreground: Paint(),
        fontSize: 25,
      ),
    ),
    foregroundColor: ThemeData().colorScheme.primary,
    actions: [
      DropdownButton(
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).primaryIconTheme.color,
        ),
        items: [
          DropdownMenuItem(
            child: Container(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                  SizedBox(width: 8),
                  Text('Sign Out'),
                ],
              ),
            ),
            value: 'signout',
          )
        ],
        onChanged: (itemIdentifier) async {
          if (itemIdentifier == 'signout') {
            await FirebaseAuth.instance.signOut();

            await GoogleSignIn().signOut(); 
          }
        },
      )
    ],
  );
}
