import 'package:flutter/material.dart';
import 'package:hotspot_project/screens/home_screen.dart';
import './theme_data.dart';
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
     theme: 
     ThemeData(
       colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const Color.fromARGB(255, 248, 174, 1),
         accentColor: Colors.blue,
         brightness: Brightness.light,
       ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      //useMaterial3: true,
    );
  }
}
