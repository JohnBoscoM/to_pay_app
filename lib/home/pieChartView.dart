// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:to_pay_app/home/pieChart.dart';

// class PieChartView extends StatelessWidget {
//   const PieChartView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 4,
//       child: LayoutBuilder(
//         builder: (context, constraint) => Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.circle,
//             // boxShadow: [
//             //   BoxShadow(
//             //     spreadRadius: 10,
//             //     blurRadius: 27,
//             //     offset: Offset(-5, -10),
//             //     color: Colors.white),

//             //   BoxShadow(
//             //     spreadRadius: -2,
//             //     blurRadius: 11,
//             //     offset: Offset(15, 15),
//             //     color: Colors.grey[500],
//             //   )
//             // ],
//           ),
//           child: Stack(
//             children: [
//               Center(
//                 child: SizedBox(
//                   width: constraint.maxWidth * 0.4,
//                   child: CustomPaint(
//                     child: Center(),
//                     foregroundPainter: PieChart(
//                       width: constraint.maxWidth * 0.8,
//                       categories: kCategories,
//                     ),
//                   ),
//                 ),
//               ),
//               Center(
//                 child: Container(
//                   height: constraint.maxWidth * 0.5,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     // boxShadow: [
//                     //   BoxShadow(
//                     //     blurRadius: 1,
//                     //     offset: Offset(-1, -1),
//                     //     color: Colors.grey.shade50,
//                     //   ),
//                     //   BoxShadow(
//                     //     spreadRadius: -2,
//                     //     blurRadius: 10,
//                     //     offset: Offset(9, 5),
//                     //     color: Colors.black.withOpacity(0.5),
//                     //   )
//                     // ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       ' 7280.20 \kr',
//                       style: GoogleFonts.aBeeZee(
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey.shade800),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
