// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitEditForm(
      String email, String userName, String dateOfBirth, BuildContext ctx,
      {String? oldPassword, String? newPassword, File? newImage}) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      setState(() {
        _isLoading = true;
      });

      if (newImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(user!.uid + '.jpg');

        await ref.putFile(newImage).whenComplete(() => print('image uploaded'));

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'username': userName,
          'email': email,
          'dateOfBirth': dateOfBirth,
          'image_url': url,
        });

        Navigator.of(context).pop();
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'username': userName,
          'email': email,
          'dateOfBirth': dateOfBirth,
        });

        Navigator.of(context).pop();
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message as String;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      print(err);
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      var message = 'An error occurred, please check your credentials!';

      // if (err.message != null) {
      //   message = err.message;
      // }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      bottomNavigationBar: NavBarComponent(selectedTab: NavigationItem.profile),
      body: EditForm(_submitEditForm, _isLoading),
    );
  }
}
