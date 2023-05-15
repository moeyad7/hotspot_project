import 'package:Hotspot/compnents/buttons/buttons.dart';
import 'package:flutter/material.dart';
import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';
import '../screens/auth_screen.dart';

class AccountRequiredScreen extends StatelessWidget {
  const AccountRequiredScreen({Key? key}) : super(key: key);
  static const routeName = '/account-required';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You must have an account to access this page.',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: CustomButton(
                  name: "Create Account",
                  color: Color(0xFFF58A07),
                  pressFunction: () {
                    Navigator.of(context).pushNamed(AuthScreen.routeName);
                  },
                ))
          ],
        ),
      ),
      bottomNavigationBar: NavBarComponent(selectedTab: NavigationItem.home),
    );
  }
}
