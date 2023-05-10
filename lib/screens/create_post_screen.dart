import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import '../compnents/nav_bar.dart';

import '../compnents/app_bar.dart';
import '/data/DUMMMY_DATA.dart';
import '../compnents/buttons/buttons.dart';

class CreatePost extends StatefulWidget {
  static const routeName = '/PostCreate';

  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: my_appBar(context),
        body: SingleChildScrollView(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(30),
              child: Text('New Post',
               style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold, 
                    color: ThemeData().colorScheme.primary, 
                  )            
            
              ),
            ),
          
            Container(
          
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                  
                ),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,  
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(30),
                height:MediaQuery.of(context).size.width * 0.6 ,
              child: TextField(
                // Single-line fields automatically scroll to the right when the text field is full  
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  
                ),
                style: TextStyle(
                  fontSize: 18,
                )
              ),
            ),

        ],),   
        ),
          bottomNavigationBar: NavBarComponent(
        selectedTab: NavigationItem.home,
      ),
        );
  }
}
