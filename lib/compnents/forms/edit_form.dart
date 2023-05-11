import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../buttons/buttons.dart';
import '../pickers/user_image_picker.dart';

class EditForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    String dateOfBirth,
    File image,
    BuildContext ctx,
  ) submitFn;

  EditForm(this.submitFn, this.isLoading);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
  void getData() async {
    //get the authenticated user data from firebase
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    //set the data to the text fields
    setState(() {
      _userEmail.text = userData['email'];
      _userName.text = userData['username'];
      _dateOfBirth.text = userData['dateOfBirth'];
      _userImage = userData['image_url'];
    });
  }

  var _userEmail = TextEditingController();
  var _userName = TextEditingController();
  var _dateOfBirth = TextEditingController();
  var _userImage;

  var _password = '';

  void _pickedImage(File image) {
    _userImage = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.text.trim(),
        _password.trim(),
        _userName.text.trim(),
        _dateOfBirth.text.trim(),
        _userImage,
        context,
      );
    }
  }

  @override
  void initState() {
    getData();

    super.initState();
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
                _userImage == null
                    ? CircularProgressIndicator()
                    : UserImagePicker(
                        userImage: _userImage,
                        type: ImageSource.camera,
                        imagePickFn: _pickedImage,
                      ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _userEmail,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
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
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Change Password'),
                            content: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                        labelText: 'New Password',
                                        hintText: 'Enter your new password'),
                                    onChanged: (value) {
                                      _password = value;
                                    },
                                    obscureText: true,
                                  ),
                                )
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
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
