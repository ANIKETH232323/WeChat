// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:wechat/Themes/constants.dart';
//
// class ReceiverMessageUI extends StatelessWidget {
//   const ReceiverMessageUI({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Padding(
//       padding: const EdgeInsets.only(top: 15,left: 85,right: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Flexible(
//                 child: SizedBox(
//                   child: Container(
//                     padding: const EdgeInsets.all(15),
//                     decoration: const BoxDecoration(
//                         color:kPrimaryColor,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(28),
//                             topRight: Radius.circular(28),
//                             bottomLeft: Radius.circular(28)
//                         )
//                     ),
//
//                     child: const Text("Hello,what are you doing guys?what about you"),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10,),
//               const CircleAvatar(child:Icon(CupertinoIcons.person) ),
//
//             ],),
//           const Padding(
//             padding: EdgeInsets.only(right: 50),
//             child: Text("2.30 PM",),
//           )
//         ],
//       ),
//     );
//   }
// }
