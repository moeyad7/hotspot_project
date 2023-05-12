import 'package:flutter/material.dart';

class ChangePasswordForm extends StatefulWidget {
  String oldPassword;
  String newPassword;

  ChangePasswordForm(this.oldPassword, this.newPassword);

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Password'),
      content: Container(
        height: 118,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value.length < 7) {
                    return 'Please enter your old password';
                  }
                  return null;
                },
                autofocus: true,
                decoration: const InputDecoration(
                    labelText: 'Old Password',
                    hintText: 'Enter your old password'),
                onChanged: (value) {
                  widget.oldPassword = value;
                },
                obscureText: true,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value.length < 7) {
                    return 'Your new password should be at least 7 characters long';
                  }
                  return null;
                },
                autofocus: true,
                decoration: const InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Enter your new password'),
                onChanged: (value) {
                  widget.newPassword = value;
                },
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
