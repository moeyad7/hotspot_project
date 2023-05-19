import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';
import '../screens/account_required.dart';
import '../compnents/buttons/buttons.dart';

class CreatePost extends StatefulWidget {
  static const routeName = '/PostCreate';

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  var _title = TextEditingController();
  var _description = TextEditingController();
  var _rating = 0.0;
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
        Navigator.of(context)
            .pushReplacementNamed(AccountRequiredScreen.routeName);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn();
  }

  void _createPost() async {
    if (_title.text.isNotEmpty &&
        _description.text.isNotEmpty &&
        _activeChips.isNotEmpty &&
        _image != null &&
        _rating != 0.0) {
      final user = await FirebaseAuth.instance.currentUser;
      final ref = FirebaseStorage.instance
          .ref()
          .child('locations_image')
          .child(user!.uid + DateTime.now().toString() + '.jpg');

      await ref.putFile(_image!).whenComplete(() => print('image uploaded'));

      final url = await ref.getDownloadURL();

      // Add New Post
      final newPost =
          await FirebaseFirestore.instance.collection('locations').add({
        'title': _title.text,
        'description': _description.text,
        'categories': _activeChips,
        'image': url,
        'userId': user.uid,
        'time': DateTime.now(),
        "ratings": [
          {
            "user_id": user.uid,
            "rating": _rating,
          }
        ],
      });

      // Add New Post to User need testing
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        "ratings": {
          FieldValue.arrayUnion([
            {"location_id": newPost.id, "rating": _rating}
          ])
        },
      });

      Navigator.of(context).pushReplacementNamed('/HomePage');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please fill all the fields'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            );
          });
    }
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
                  controller: _title,
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
                    controller: _description,
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
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _getImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: _image != null
                            ? Image.file(_image!, fit: BoxFit.cover)
                            : Icon(
                                Icons.add_a_photo,
                                size: 40.0,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                // padding: EdgeInsets.only(left: 30, top: 10),

                child: Column(
                  children: [
                    Text('Your Rating',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                margin: EdgeInsets.only(top: 20),
                child: CustomButton(
                  name: 'Post',
                  color: Color(0xFF2FC686),
                  pressFunction: _createPost,
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
