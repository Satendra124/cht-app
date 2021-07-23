// import 'package:cht/models/user.dart';
// import 'package:cht/screens/report.dart';
// import 'package:cht/screens/widgets/addOn/month_picker.dart';
// import 'package:cht/util/colorConstants.dart';
// import 'package:cht/util/ui_helper.dart';
// import 'package:flutter/material.dart';

// class DateSelector extends StatelessWidget {
//   PickerMode typeOfPick = PickerMode.day;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.backgroundColor,
//       ),
//       backgroundColor: lighten(AppColors.backgroundColor, 0.05),
//       body: SingleChildScrollView(
//         child: Container(
//           width: screenWidth,
//           height: screenHeight - 100,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   width: screenWidth,
//                   height: 100,
//                   child: Center(
//                     child: Text(
//                       "Report",
//                       style: TextStyle(
//                           fontSize: 50,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.textColor),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           DateTimeRange dateTimeRange =
//                               await showDateRangePicker(
//                                   confirmText: "Select",
//                                   context: context,
//                                   firstDate: DateTime.utc(2000),
//                                   lastDate: DateTime.now());
//                           if (dateTimeRange != null) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ReportScreen(
//                                       dateTimeRange.start, dateTimeRange.end),
//                                 ));
//                           }
//                         },
//                         child: Text("Custom"),
//                         style: AppStyles.buttonStyleBIG,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           DateTime day = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime.utc(2000),
//                               lastDate: DateTime.now());
//                           if (day != null) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ReportScreen(day, day),
//                                 ));
//                           }
//                         },
//                         child: Text("Daily"),
//                         style: AppStyles.buttonStyleBIG,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           DateTime month = await showMonthPicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime.utc(2000),
//                               lastDate: DateTime.now());
//                           if (month != null) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ReportScreen(
//                                       month, month.add(Duration(days: 30))),
//                                 ));
//                           }
//                         },
//                         child: Text("Monthly"),
//                         style: AppStyles.buttonStyleBIG,
//                       ),
//                     ),
//                   ],
//                 ),

//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: ElevatedButton(
//                 //     onPressed: () async {
//                 //       DateTime year = await showDatePicker(
//                 //           initialDatePickerMode: DatePickerMode.year,
//                 //           context: context,
//                 //           initialDate: DateTime.now(),
//                 //           firstDate: DateTime.utc(2000),
//                 //           lastDate: DateTime.now());
//                 //       if (year != null) {
//                 //         Navigator.push(
//                 //             context,
//                 //             MaterialPageRoute(
//                 //               builder: (context) => ReportScreen(
//                 //                   year, year.add(Duration(days: 365))),
//                 //             ));
//                 //       }
//                 //     },
//                 //     child: Text("Yearly"),
//                 //     style: AppStyles.buttonStyleBIG,
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// enum PickerMode { month, day, year }

// // Container(
// //                   width: screenWidth,
// //                   height: 60,
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                     children: [
// //                       ElevatedButton(
// //                           onPressed: () {
// //                             showDateRangePicker(
// //                               context: context,
// //                               firstDate: DateTime.utc(2000),
// //                               lastDate: DateTime.now(),
// //                             );
// //                           },
// //                           child: Text("Month")),
// //                       ElevatedButton(onPressed: () {}, child: Text("Day")),
// //                       ElevatedButton(onPressed: () {}, child: Text("Year")),
// //                     ],
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   height: 20,
// //                 ),
// //                 Container(
// //                   width: screenWidth,
// //                   height: 300,
// //                   child: YearPicker(
// //                       firstDate: DateTime.utc(2000),
// //                       lastDate: DateTime.now(),
// //                       selectedDate: DateTime.now(),
// //                       onChanged: (e) {
// //                         print(e);
// //                       }),
// //                 ),
// //                 Container(
// //                   width: screenWidth,
// //                   height: 300,
// //                   child: CalendarDatePicker(
// //                       initialDate: DateTime.now(),
// //                       firstDate: DateTime.utc(2000),
// //                       lastDate: DateTime.now(),
// //                       onDateChanged: (e) {
// //                         print(e);
// //                       }),
// //                 ),
// //                 Container(
// //                   width: screenWidth,
// //                   height: 300,
// //                   child: CalendarDatePicker(
// //                       initialDate: DateTime.now(),
// //                       firstDate: DateTime.utc(2000),
// //                       lastDate: DateTime.now(),
// //                       onDateChanged: (e) {
// //                         print(e);
// //                       }),
// //                 ),
