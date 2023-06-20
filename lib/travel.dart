// import 'dart:ui';

// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
// import 'package:flutter/material.dart';
// import 'package:tune_spot/screens/homescreen.dart';
// import 'package:tune_spot/screens/library.dart';
// import 'package:tune_spot/screens/playscreeen.dart';
// import 'package:tune_spot/screens/search.dart';
// import 'screens/artist.dart';

// class travel extends StatefulWidget {
//   const travel({super.key});

//   @override
//   State<travel> createState() => _travelState();
// }

// class _travelState extends State<travel> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//         ),
//         extendBody: true,
//         body: Padding(
//           padding: const EdgeInsets.all(22),
//           child: Container(
//             child: Column(
//               children: [
//                 Stack(
//                   // alignment: Alignment.center,
//                   children: [
//                     Image.network(
//                       'https://www.nme.com/wp-content/uploads/2019/05/Vinyl-records-4-696x442.jpg',
//                       fit: BoxFit.cover,
//                       // width: double.infinity,
//                       // height: double.infinity,
//                     ),
//                     Positioned.fill(
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                         child: Container(color: Colors.transparent),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 30, left: 50),
//                       child: Positioned(
//                         child: Image.network(
//                           'https://www.nme.com/wp-content/uploads/2019/05/Vinyl-records-4-696x442.jpg',
//                           width: 250,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Stack(children: [
//                       Container(
//                         child: CircleAvatar(
//                             backgroundColor: Colors.black, radius: 25),
//                       ),
//                       Positioned(
//                         child: IconButton(
//                             onPressed: () {},
//                             icon: Icon(
//                               Icons.play_arrow,
//                               size: 35,
//                               color: Colors.white,
//                             )),
//                       ),
//                     ]),
//                     IconButton(
//                         onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
//                   ],
//                 ),
//                 GestureDetector(
//                   onTap: () => Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Playing(),
//                       )),
//                   child: ListTile(
//                     title: Text(
//                       'Song Name',
//                       style:
//                           TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
//                     ),
//                     subtitle: Text('Movie', style: TextStyle(fontSize: 18)),
//                     trailing: IconButton(
//                         onPressed: () {}, icon: Icon(Icons.more_vert)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: CurvedNavigationBar(
//           backgroundColor: Colors.transparent,
//           items: [
//             CurvedNavigationBarItem(
//               child: Icon(Icons.home_outlined),
//               label: 'Home',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.search),
//               label: 'Search',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.folder),
//               label: 'Library',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.perm_identity),
//               label: 'Artists',
//             ),
//           ],
//           onTap: (index) {
//             switch (index) {
//               case 0:
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Homescreen()));
//                 break;
//               case 1:
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => Search()));
//                 break;
//               case 2:
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Library()));
//                 break;
//               case 3:
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Artists()));
//                 break;
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
