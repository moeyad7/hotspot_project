// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';
import 'package:intl/intl.dart';
import '../compnents/buttons/buttons.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/EditProfileScreen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController dateOfBirth = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';

  String _userName = '';

  String _userPassword = '';

  String _userReEnterPassword = '';

  String _userDateOfBirth = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: my_appBar(context),
      bottomNavigationBar: NavBarComponent(selectedTab: NavigationItem.profile),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Logo.png',
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white)),
                      filled: true,
                      fillColor: Color(0xFFD6D6D6),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white)),
                      filled: true,
                      fillColor: Color(0xFFD6D6D6),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white)),
                      filled: true,
                      fillColor: Color(0xFFD6D6D6),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white)),
                      filled: true,
                      fillColor: Color(0xFFD6D6D6),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: dateOfBirth,
                    decoration: InputDecoration(
                      labelText: "Date of birth",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD6D6D6),
                    ),
                    onTap: () async {
                      DateTime date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());
                      date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now()) as DateTime;

                      dateOfBirth.text = DateFormat('dd/MM/yyyy').format(date);
                    },
                    onSaved: (value) {
                      _userDateOfBirth = value!;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 40,
                        width: 122,
                        child: CustomButton(
                          name: "Configure",
                          color: Color(0xFF2FC686),
                          pressFunction: () {},
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 122,
                        child: CustomButton(
                          name: "Edit Image",
                          color: Color(0xFFD6D6D6),
                          pressFunction: () {},
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
