// import 'package:flutter/material.dart';

// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Search for a school',
//           style: TextStyle(
//             fontSize: 20,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: searchController,
//               decoration: const InputDecoration(
//                 labelText: 'Search',
//                 hintText: 'Search for a school',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(25.0),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredSchools.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: InkWell(
//                     splashColor: Colors.blue.withAlpha(100),
//                     onTap: () {
//                       Navigator.pushNamed(context, '/school_details',
//                           arguments: schools[index]);
//                     },
//                     child: ListTile(
//                       title: Text(filteredSchools[index]['name']),
//                       subtitle: Text(filteredSchools[index]['description']),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar:
//           const NavBarComponent(selectedTab: NavigationItem.schoolSearch),
//     );
//   }
// }
