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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Text('New Post',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: ThemeData().colorScheme.primary,
                  )),
            ),
            Container(
          
              padding: EdgeInsets.only(left:30,right:30,bottom: 20,top:15),
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
                padding: EdgeInsets.only(left:30, right:30),
                height:MediaQuery.of(context).size.width * 0.4 ,
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
                  )),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 30, top: 10),
              child: Text('Categories',
               style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold, 
                    color: ThemeData().colorScheme.primary, 
                  )            
            
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, top: 10,right: 30),

              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children:[Wrap(
                  spacing: 3.0,
                 // gap between adjacent chips
                  children: [
                    CustomButton(
                      name: 'Nature',
                      color:  ThemeData().colorScheme.tertiary,
                      type: 'chips',
                    ),
                    CustomButton(
                      name: 'History',
                      color: ThemeData().colorScheme.tertiary,
                      type: 'chips',
                    ),
                    CustomButton(
                      name: 'Entertainment',
                      color: ThemeData().colorScheme.tertiary,
                      type: 'chips',
                    ),
                    CustomButton(
                      name: 'Food',
                      color: ThemeData().colorScheme.tertiary,
                      type: 'chips',
                    )]),
                    Wrap(
                      spacing:3,
                      children:<Widget>[
                    CustomButton(
                      name: 'Adventure',
                      color: ThemeData().colorScheme.tertiary,
                      type: 'chips',
                    ),
                    CustomButton(
                      name: 'Religion ',
                      color: ThemeData().colorScheme.tertiary,
                      type: 'chips',
                    ),
                    CustomButton(
                      name: 'Shopping',
                      color: ThemeData().colorScheme.tertiary,
                      type: 'chips',
                    ),
                    CustomButton(
                      name: 'Culture',
                      color: ThemeData().colorScheme.tertiary,
                      type: 'chips',
                    ),
                  ],
                ),
                ]
                ),
              
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Post'),
                      style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
                      ),  
                    ),
            ),

        ],), 
          
        ),
    
      bottomNavigationBar: NavBarComponent(
        selectedTab: NavigationItem.add,
      )
    );
  }
}
