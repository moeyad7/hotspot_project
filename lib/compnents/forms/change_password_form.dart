import 'package:flutter/material.dart';

class ChangePasswordForm extends StatefulWidget {
  String oldPassword;
  String newPassword;
  final void Function(
    String oldPassword,
    String newPassword,
  ) getPassword;

  ChangePasswordForm(this.oldPassword, this.newPassword, this.getPassword);

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();

  void _checkValidity() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      widget.getPassword(widget.oldPassword, widget.newPassword);
      Navigator.pop(context, 'OK');
    } else {
      print('Invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Password'),
      content: Container(
        height: 170,
        child: Form(
          key: _formKey,
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
                onChanged: (newValue) {
                  widget.oldPassword = newValue;
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
                onChanged: (newValue) {
                  widget.newPassword = newValue;
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
          onPressed: _checkValidity,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
