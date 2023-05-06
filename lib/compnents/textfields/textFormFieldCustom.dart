import 'package:flutter/material.dart';

class TexFormFieldCustom extends StatelessWidget {
  final Function? valid;
  final String label;
  final Function? save;
  final bool obscure;
  const TexFormFieldCustom({
    required this.valid,
    required this.label,
    required this.save,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: valid as String? Function(String?)?,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Color(0xFFF58A07).withOpacity(0.3),
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: save as void Function(String?)?,
      obscureText: obscure,
    );
  }
}
