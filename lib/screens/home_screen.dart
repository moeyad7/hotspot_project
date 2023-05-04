import 'package:flutter/material.dart';
import '../app_router.dart';
import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AppRouter().generateRoute;
    return Scaffold(
      appBar: my_appBar(context),
       
      
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to the next page'),
          onPressed: () {
            Navigator.pushNamed(context, '/second');
          },
        ),
      ),
    );
  }
}
