import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Color color;
  final String type;
  final IconData? icon;

  const CustomButton({
    Key? key,
    required this.name,
    required this.color,
    required this.type,
    this.icon,
  }) : super(key: key);

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
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: color,
              onPrimary: Colors.white,
              shape: StadiumBorder(),
            ),
            child: Row(
              children: [if (icon != null) Icon(icon), Text(name)],
            ));
    }
  }
}
