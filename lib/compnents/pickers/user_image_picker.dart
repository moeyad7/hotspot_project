import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../buttons/buttons.dart';

class UserImagePicker extends StatefulWidget {
  final userImage;

  UserImagePicker({required this.userImage});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  var _pickedImage;


  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage == null
              ? NetworkImage(widget.userImage)
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
