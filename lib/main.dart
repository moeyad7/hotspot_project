import 'package:flutter/material.dart';
import 'package:hotspot_project/screens/home_screen.dart';
import 'compnents/app_bar.dart';
import 'compnents/nav_bar.dart';
import './app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: HomePage.routeName,

      title: 'Hotspot',
      // theme: lightThemeData(context),
      // darkTheme: darkThemeData(context),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFFF58A07),
          secondary: Color(0xFF228CE5),
          tertiary: Color(0xFF2FC686),
          error: Color(0xFFF32424),
          background: Color(0xFFFDF1ED),
          surface: Color(0x00000000),
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      //useMaterial3: true,
    );
  }
}
