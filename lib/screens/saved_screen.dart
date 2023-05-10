// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';

class SavedScreen extends StatelessWidget {
  static const routeName = '/SavedScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: my_appBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark,
                    color: Color(0xFFF58A07),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Saved • " + "69",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1),
          ],
        ),
      ),
      bottomNavigationBar: NavBarComponent(selectedTab: NavigationItem.profile),
    );
  }
}
