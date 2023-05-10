import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import '/data/DUMMMY_DATA.dart';
import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';
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
        appBar: MyAppBar(context),
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
                          labelText: "Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF58A07).withOpacity(0.3),
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
                          labelText: "Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF58A07).withOpacity(0.3),
                        ),
                style: TextStyle(
                  fontSize: 18,
                )
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 10),
              child: Text('Categories',
               style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold, 
                    color: ThemeData().colorScheme.primary, 
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
