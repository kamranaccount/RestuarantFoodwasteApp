// import 'dart:js';
//
// import 'package:flutter/material.dart';
// import 'package:rating_dialog/rating_dialog.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Restaurants',
//           style: TextStyle(
//             color: Colors.teal[500],
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(32),
//         child: ElevatedButton(
//           child: Text('feedback'),
//           onPressed: () {},
//         ),
//       ),
//     );
//   }
//
//   void feedback() {
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (context) {
//           return RatingDialog(
//               title: Text("Rate Us"),
//               message: Text("Tap on stars to rate us"),
//               image: Icon(
//                 Icons.star,
//                 color: Colors.teal,
//                 size: 100,
//               ),
//               submitButtonText: "SUBMIT",
//               onSubmitted: (response) {
//                 print('press');
//               });
//         });
//   }
// }
