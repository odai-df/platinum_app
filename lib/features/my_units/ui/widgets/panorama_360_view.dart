// import 'package:flutter/material.dart';
// import 'package:panorama_viewer/panorama_viewer.dart';
//
// class Panorama360View extends StatelessWidget {
//   final String imageUrl;
//
//   const Panorama360View({
//     super.key,
//     required this.imageUrl,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: Stack(
//         children: [
//           SizedBox(
//             height: 260,
//             width: double.infinity,
//             child: PanoramaViewer(
//               image: NetworkImage(imageUrl),
//               initialFOV: 90,
//               minFOV: 30,
//               maxFOV: 120,
//             ),
//           ),
//
//           Positioned(
//             top: 12,
//             left: 12,
//             child: Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 11,
//                 vertical: 7,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(.55),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.threesixty,
//                     color: Colors.white,
//                     size: 18,
//                   ),
//                   SizedBox(width: 5),
//                   Text(
//                     "360°",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           Positioned(
//             bottom: 12,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 7,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(.45),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Text(
//                   "Drag to explore",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 11,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }