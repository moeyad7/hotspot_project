// ignore_for_file: prefer_if_null_operators, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Color color;
  final String? type;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? pressFunction;

  const CustomButton(
      {Key? key,
      required this.name,
      required this.color,
      this.type,
      this.icon,
      this.iconColor,
      this.pressFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'chips':
        return Chip(
          label: Row(
            children: [
              if (icon != null) Icon(icon),
              Text(name),
            ],
          ),
          backgroundColor: color,
        );
      case 'icons':
        return IconButton(
          icon: Icon(icon),
          onPressed: () {},
          color: color,
        );
      default:
        return ElevatedButton(
            onPressed: pressFunction == null ? () {} : pressFunction,
            style: ElevatedButton.styleFrom(
              primary: color,
              onPrimary: Colors.white,
              shape: StadiumBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: iconColor != null ? iconColor : null,
                  ),
                if (icon != null) SizedBox(width: 15),
                Text(
                  name,
                  style: TextStyle(color: Colors.black),
                )
              ],
            ));
    }
  }
}
