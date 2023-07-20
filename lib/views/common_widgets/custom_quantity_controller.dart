// import 'package:flutter/material.dart';
//
// class CustomQuantityController extends StatelessWidget {
//   const CustomQuantityController({Key? key, required this.color, this.fun, required this.icon}) : super(key: key);
//
//   final Color color ;
//   final void Function()? fun;
//   final IconData icon ;
//
//   @override
//   Widget build(BuildContext context) {
//      return Flexible(
//       flex: 2,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 5),
//         child: Material(
//           color: color,
//           borderRadius: BorderRadius.circular(12),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: () {
//               fun;
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(6.0),
//               child: Icon(
//                 icon,
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
