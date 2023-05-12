import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../buttons/buttons.dart';
import '../pickers/user_image_picker.dart';
import '../forms/change_password_form.dart';

class EditForm extends StatefulWidget {
  final void Function(
    String email,
    String userName,
    String dateOfBirth,
    BuildContext ctx, {
    File? newImage,
    String? oldPassword,
    String? newPassword,
  }) submitFn;
  final bool isLoading;

  EditForm(this.submitFn, this.isLoading);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail;
  var _userName = TextEditingController();
  var _dateOfBirth = TextEditingController();
  var _profileImage;
  var _oldPassword = '';
  var _newPassword = '';

  var _userImage;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    //get the authenticated user data from firebase
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    //set the data to the text fields
    setState(() {
      _userEmail = userData['email'];
      _userName.text = userData['username'];
      _dateOfBirth.text = userData['dateOfBirth'];
      _profileImage = userData['image_url'];
    });
  }

  void _pickedImage(File image) {
    _userImage = image;
  }

  void _getPasswords(String oldpass,String newpass){
    _oldPassword = oldpass;
    _newPassword = newpass;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    print('edit form file');
    print(_oldPassword);
    print(_newPassword);

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail,
        _userName.text.trim(),
        _dateOfBirth.text.trim(),
        context,
        newImage: _userImage,
        oldPassword: _oldPassword.trim() == '' ? null : _oldPassword.trim(),
        newPassword: _newPassword.trim() == '' ? null : _newPassword.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _profileImage == null
                    ? CircularProgressIndicator()
                    : UserImagePicker(
                        profileImage: _profileImage,
                        type: ImageSource.camera,
                        imagePickFn: _pickedImage,
                      ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _userName,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 3) {
                      return 'Please enter a username.';
                    }
                    return null;
                  },
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
                  controller: _dateOfBirth,
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

                    _dateOfBirth.text = DateFormat('dd/MM/yyyy').format(date);
                  },
                ),
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF228CE5)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      label: const Text('Change Password'),
                      onPressed: () {
                        //change the password
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              ChangePasswordForm(_oldPassword, _newPassword,_getPasswords),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 40,
                      width: 174,
                      child: CustomButton(
                        name: "Save Changes",
                        color: Color(0xFF2FC686),
                        pressFunction: _trySubmit,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
