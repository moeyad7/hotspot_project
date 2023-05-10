// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';

class VisitedScreen extends StatelessWidget {
  static const routeName = '/VisitedScreen';

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
                    Icons.check_circle,
                    color: Color(0xFF2FC686),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Visited • " + "69",
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
