import 'package:flutter/material.dart';

AppBar my_appBar(BuildContext context) {
  return AppBar(
    title: Text(
      'H' + '🔥' + 'tspot',
      textAlign: TextAlign.left,
      style: TextStyle(
        foreground: Paint(),
        fontSize: 25,
      ),
    ),
    foregroundColor: ThemeData().colorScheme.primary,
  );
}
