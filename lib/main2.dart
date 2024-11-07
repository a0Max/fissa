// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Trip Details',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: TripDetailsPage(),
//     );
//   }
// }
//
// class TripDetailsPage extends StatefulWidget {
//   @override
//   _TripDetailsPageState createState() => _TripDetailsPageState();
// }
//
// class _TripDetailsPageState extends State<TripDetailsPage> {
//   bool isTripDetailsExpanded = false;
//   bool isEndPointExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('تفاصيل الرحلة'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Trip Details Expansion
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isTripDetailsExpanded = !isTripDetailsExpanded;
//                 });
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(
//                     isTripDetailsExpanded
//                         ? Icons.expand_less
//                         : Icons.expand_more,
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     'تفاصيل الرحلة',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     textDirection: TextDirection.rtl,
//                   ),
//                 ],
//               ),
//             ),
//             if (isTripDetailsExpanded)
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   textDirection: TextDirection.rtl,
//                   children: [
//                     Text('من', style: TextStyle(color: Colors.orange)),
//                     Text('شارع المدار, طرابلس ليبيا',
//                         style: TextStyle(fontSize: 16)),
//                     SizedBox(height: 8),
//                     Text('إلى', style: TextStyle(color: Colors.blue)),
//                     Text('شارع المدار, طرابلس ليبيا',
//                         style: TextStyle(fontSize: 16)),
//                   ],
//                 ),
//               ),
//             Divider(),
//
//             // End Point Expansion
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isEndPointExpanded = !isEndPointExpanded;
//                 });
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(
//                     isEndPointExpanded ? Icons.expand_less : Icons.expand_more,
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     'نقطة النهاية',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     textDirection: TextDirection.rtl,
//                   ),
//                 ],
//               ),
//             ),
//             if (isEndPointExpanded)
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       textDirection: TextDirection.rtl,
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: Colors.blue[100],
//                           child: Icon(Icons.person, color: Colors.blue),
//                         ),
//                         SizedBox(width: 8),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           textDirection: TextDirection.rtl,
//                           children: [
//                             Text('علي محمود',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.blue)),
//                             Text('092 345 33 44',
//                                 style: TextStyle(fontSize: 16)),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.call, color: Colors.green),
//                           onPressed: () {
//                             // Implement call action here
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.message, color: Colors.blue),
//                           onPressed: () {
//                             // Implement message action here
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
