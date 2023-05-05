import 'package:flutter/material.dart';

import './app_router.dart';
import './screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/post_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // onGenerateRoute: AppRouter().generateRoute,
      title: 'Hotspot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFFF58A07),
          onPrimary: Color(0xFFF58A07),
          secondary: Color(0xFF228CE5),
          onSecondary: Color(0xFF228CE5),
          tertiary: Color(0xFF2FC686),
          onTertiary: Color(0xFF2FC686),
          error: Color(0xFFF32424),
          onError: Color(0xFFF32424),
          background: Color(0xFFFDF1ED),
          onBackground: Color(0xFFFDF1ED),
          surface: Color(0x00000000),
          onSurface: Color(0x00000000),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
      routes: {
        AuthScreen.routeName: (context) => AuthScreen(),
        HomePage.routeName: (context) => HomePage(),
        PostDetail.routeName: (context) => PostDetail(),
      },
    );
  }
}
