import 'package:flutter/material.dart';
import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';

class EditProfileScreen extends StatelessWidget {
  static const routeName = '/EditProfileScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: my_appBar(context),
      bottomNavigationBar: NavBarComponent(selectedTab: NavigationItem.profile),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/Logo.png',
              height: 150,
              width: 150,
            ),
            TextFormField(),
            TextFormField(),
            TextFormField(),
            TextFormField(),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
