import 'package:flutter/material.dart';

AppBar my_appBar(BuildContext context) {
  return AppBar(
    title: Text(
      'H' + '🔥' + 'tspot',
      style: TextStyle(
        foreground: Paint(),
        fontSize: 25,
      ),
    ),
    foregroundColor: ThemeData().colorScheme.primary,
  );
}
