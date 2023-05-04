import 'package:flutter/material.dart';

import './screens/auth_screen.dart';
import 'screens/home_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'AuthScreen':
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case 'HomePage':
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
    }
  }
}
