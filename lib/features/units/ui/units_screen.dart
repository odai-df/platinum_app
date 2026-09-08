// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../logic/units_cubit.dart';
// import '../logic/units_state.dart';
//
// class UnitsScreen extends StatelessWidget {
//   const UnitsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Units")),
//       body: BlocBuilder<UnitsCubit, UnitsState>(
//         builder: (context, state) {
//           return state.when(
//             initial: () {
//               context.read<UnitsCubit>().getUnits();
//               return const SizedBox();
//             },
//             loading: () =>
//             const Center(child: CircularProgressIndicator()),
//             success: (units) {
//               return ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: units.length,
//                 itemBuilder: (context, index) {
//                   final unit = units[index];
//
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 16),
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                           offset: const Offset(0, 5),
//                         )
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // TOP ROW
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               unit.type.toUpperCase(),
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: unit.status == "available"
//                                     ? Colors.green.withOpacity(0.1)
//                                     : Colors.red.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 unit.status,
//                                 style: TextStyle(
//                                   color: unit.status == "available"
//                                       ? Colors.green
//                                       : Colors.red,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(height: 10),
//
//                         Text(
//                           "Unit: ${unit.unitNumber}",
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         Row(
//                           children: [
//                             Text("Floor: ${unit.floor}"),
//                             const SizedBox(width: 10),
//                             Text("Rooms: ${unit.roomsCount}"),
//                           ],
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         Text(
//                           "Area: ${unit.area} m²",
//                           style: TextStyle(color: Colors.grey[600]),
//                         ),
//
//                         const SizedBox(height: 12),
//
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Text(
//                             "${unit.price}",
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//             error: (error) =>
//                 Center(child: Text(error)),
//           );
//         },
//       ),
//     );
//   }
// }