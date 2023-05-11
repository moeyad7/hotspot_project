import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../buttons/buttons.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  var _pickedImage;

  var _userImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
  }

  void getImage() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    //set the data to the text fields
    setState(() {
      _userImage = userData['image_url'];
    });
  }

  @override
  void initState() {
    getImage();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: _pickedImage == null
              ? NetworkImage(_userImage)
              : FileImage(_pickedImage) as ImageProvider,
        ),
        Container(
          height: 40,
          width: 174,
          child: CustomButton(
            name: "Edit Image",
            color: Color(0xFFD6D6D6),
            icon: Icons.camera,
            iconColor: Colors.black,
            pressFunction: _pickImage,
          ),
        ),
      ],
    );
  }
}
