// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';
import '../compnents/forms/edit_form.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/EditProfileScreen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      bottomNavigationBar: NavBarComponent(selectedTab: NavigationItem.profile),
      body: EditForm(),
    );
  }
}
