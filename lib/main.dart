// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/home_screen.dart';
import './screens/auth_screen.dart';
import './screens/saved_screen.dart';
import './screens/visited_screen.dart';
import './screens/profile_screen.dart';
import 'compnents/notifications/notifications.dart';
import 'screens/account_required.dart';
import 'screens/post_details_screen.dart';
import './screens/create_post_screen.dart';
import './screens/edit_profile_screen.dart';
import 'screens/search_screen.dart';

final customSwatch = MaterialColor(
  0xFFF58A07,
  <int, Color>{
    50: Color(0xFFFFFCE5),
    100: Color(0xFFFFF2B2),
    200: Color(0xFFFFE680),
    300: Color(0xFFFFD24D),
    400: Color(0xFFFFC22D),
    500: Color(0xFFF58A07),
    600: Color(0xFFD16D05),
    700: Color(0xFFAF4F03),
    800: Color(0xFF8D3102),
    900: Color(0xFF6B1300),
  },
);
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  NotificationService().initNotification();
  
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotspot',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Colors.black),
          displayMedium: TextStyle(color: Colors.black),
          displaySmall: TextStyle(color: Colors.black),
          headlineMedium: TextStyle(color: Colors.black),
          headlineSmall: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Colors.black),
          titleSmall: TextStyle(color: Colors.black),
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
        primarySwatch: customSwatch,
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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              return AuthScreen();
            } else {
              return HomePage();
            }
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      routes: {
        AuthScreen.routeName: (context) => AuthScreen(),
        HomePage.routeName: (context) => HomePage(),
        PostDetail.routeName: (context) => PostDetail(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        SavedScreen.routeName: (context) => SavedScreen(),
        VisitedScreen.routeName: (context) => VisitedScreen(),
        EditProfileScreen.routeName: (context) => EditProfileScreen(),
        CreatePost.routeName: (context) => CreatePost(),
        AccountRequiredScreen.routeName: (context) => AccountRequiredScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),
      },
    );
  }
}
