import 'package:flutter/material.dart';

AppBar my_appBar(BuildContext context) {
  return AppBar(
    title: Text(
      'H' + '🔥' + 'tspot',
      style: TextStyle(
        color: ThemeData().colorScheme.surface,
        fontSize: 25,
      ),
    ),
    foregroundColor: ThemeData().colorScheme.primary,
  );
}
