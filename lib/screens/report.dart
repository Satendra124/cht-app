// import 'package:cht/models/user.dart';
// import 'package:cht/screens/widgets/report/reportWidget.dart';
// import 'package:cht/services/ReportService.dart';
// import 'package:cht/util/ui_helper.dart';
// import 'package:flutter/material.dart';

// class ReportScreen extends StatelessWidget {
//   final DateTime startDate;
//   final DateTime endDate;
//   ReportScreen(this.startDate, this.endDate);
//   @override
//   Widget build(BuildContext context) {
//     //DateTime today = DateTime.now();
//     Future<Report> report = ReportService().getReport(
//         DateTime.utc(startDate.year, startDate.month, startDate.day),
//         DateTime.utc(endDate.year, endDate.month, endDate.day + 1));
//     return Scaffold(
//         backgroundColor: Color(0xff273C5C),
//         appBar: AppBar(
//           title: Text("Report"),
//           backgroundColor: Color(0xff273C5C),
//         ),
//         body: SafeArea(
//           child: FutureBuilder(
//               future: report,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData)
//                   return ReportWidget(
//                     report: snapshot.data,
//                     width: screenWidth,
//                     showpin: false,
//                   );
//                 else
//                   return Container(
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//               }),
//         ));
//   }
// }
