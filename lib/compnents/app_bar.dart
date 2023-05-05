import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

AppBar my_appBar(BuildContext context) {
  return AppBar(
    title: Text(
      'H' + '🔥' + 'tspot',
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
                  Icon(Icons.exit_to_app),
                  SizedBox(width: 8),
                  Text('Logout'),
                ],
              ),
            ),
            value: 'logout',
          )
        ],
        onChanged: (itemIdentifier) {
          if (itemIdentifier == 'logout') {
            FirebaseAuth.instance.signOut();
          }
        },
      )
    ],
  );
}
