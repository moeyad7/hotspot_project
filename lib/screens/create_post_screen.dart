import 'dart:io';

import 'package:Hotspot/screens/Account_Required.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';
import '../screens/auth_screen.dart';
import '../compnents/buttons/buttons.dart';

class CreatePost extends StatefulWidget {
  static const routeName = '/PostCreate';

  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final ImagePicker _picker = ImagePicker();
  File _image = File("");
  List<String> _inactiveChips = [
    'Nature',
    'History',
    'Entertainment',
    'Food',
    'Adventure',
    'Religion',
    'Shopping',
    'Culture'
  ];
  List<String> _activeChips = [];

  void isLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacementNamed(AccountRequiredScreen.routeName);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn();
  }

  Widget _buildChips() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: _inactiveChips
          .map((chip) => ChoiceChip(
                label: Text(
                  chip,
                  style: TextStyle(
                    color: _activeChips.contains(chip)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                selected: _activeChips.contains(chip),
                onSelected: (selected) => _activateChip(selected, chip),
                selectedColor: Colors.blue,
                backgroundColor: _activeChips.contains(chip)
                    ? Color(0xFF228CE5).withOpacity(0.4)
                    : Color(0xFF228CE5).withOpacity(0.4),
              ))
          .toList(),
    );
  }

  void _activateChip(bool selected, String chip) {
    setState(() {
      if (selected) {
        _activeChips.add(chip);
      } else {
        _activeChips.remove(chip);
      }
    });
  }

  Future<void> _getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Text('New Post',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 15),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF58A07).withOpacity(0.3),
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                height: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF58A07).withOpacity(0.3),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 30, top: 10),
                child: Text('Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 30, top: 10, right: 30),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(children: [
                    Wrap(
                        spacing: 3.0,
                        // gap between adjacent chips
                        children: [_buildChips()]),
                  ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: _image.path.isNotEmpty
                        ? Image.file(_image, fit: BoxFit.cover)
                        : Icon(
                            Icons.add_a_photo,
                            size: 40.0,
                            color: Colors.grey,
                          ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                margin: EdgeInsets.only(top: 20),
                child: CustomButton(
                  name: 'Post',
                  color: Color(0xFF2FC686),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavBarComponent(
          selectedTab: NavigationItem.add,
        ));
  }
}
