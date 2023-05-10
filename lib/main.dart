// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/edit_profile_screen.dart';
import './screens/saved_screen.dart';
import './screens/visited_screen.dart';
import './screens/profile_screen.dart';
import './screens/create_post_screen.dart';
import './app_router.dart';
import './screens/home_screen.dart';
import './screens/auth_screen.dart';
import 'screens/post_details_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      },
    );
  }
}
