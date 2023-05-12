import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../buttons/buttons.dart';

class UserImagePicker extends StatefulWidget {
  final profileImage;
  final type;
  final void Function(File pickedImage) imagePickFn;

  UserImagePicker(
      {this.profileImage, required this.imagePickFn, required this.type});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  var _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();

    final imageFile = await picker.pickImage(
      source: widget.type,
      imageQuality: 50,
      maxHeight: 150,
    );
    final pickedImageFile = File(imageFile!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage == null
              ? NetworkImage(widget.profileImage)
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
