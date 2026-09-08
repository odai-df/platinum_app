// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ServicesSection extends StatelessWidget {
//   const ServicesSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 90,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         children: const [
//           _ServiceItem("Buy"),
//           _ServiceItem("Rent" ),
//           _ServiceItem("Sell"),
//           _ServiceItem("Mortgage"),
//         ],
//       ),
//     );
//   }
// }
//
// class _ServiceItem extends StatelessWidget {
//   final String title;
//
//   const _ServiceItem(this.title);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 80,
//       margin: const EdgeInsets.only(right: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 5,
//           )
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(title),
//         ],
//       ),
//     );
//   }
// }