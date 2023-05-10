// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';

import './saved_screen.dart';
import './visited_screen.dart';
import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';
import './edit_profile_screen.dart';
import '../compnents/buttons/buttons.dart';


class ProfileScreen extends StatelessWidget {
  static const routeName = '/ProfileScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Image.asset(
                  'assets/images/empty_profile.jpg',
                  height: 150,
                  width: 150,
                ),
                SizedBox(width: 50),
                Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  '69',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Ratings',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Text(
                                  '169',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Comments',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    CustomButton(
                      name: 'Saved • ' + '69',
                      color: Color(0xFFD9D9D9),
                      icon: Icons.bookmark,
                      iconColor: Color(0xFFF58A07),
                      pressFunction: () {
                        Navigator.of(context).pushNamed(SavedScreen.routeName);
                      },
                    ),
                    CustomButton(
                      name: 'Visited • ' + '69',
                      color: Color(0xFFD9D9D9),
                      icon: Icons.check_circle,
                      iconColor: Color(0xFF2FC686),
                      pressFunction: () {
                        Navigator.of(context)
                            .pushNamed(VisitedScreen.routeName);
                      },
                    ),
                  ],
                )
              ]),
              SizedBox(
                height: 7,
              ),
              Center(
                  widthFactor: 1.5,
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: Color(0xFF2FC686),
                      ),
                      Text(
                        'Marwan Tawfik',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Container(
                width: 130,
                height: 40,
                child: CustomButton(
                  name: 'Edit Profile',
                  color: Color(0xFF2FC686),
                  pressFunction: () {
                    Navigator.of(context)
                        .pushNamed(EditProfileScreen.routeName);
                  },
                ),
              ),
              Column(
                children: [
                  Column(
                    children: [
                      Divider(),
                      Text('Your Posts'),
                      Divider(),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBarComponent(
        selectedTab: NavigationItem.profile,
      ),
    );
  }
}
