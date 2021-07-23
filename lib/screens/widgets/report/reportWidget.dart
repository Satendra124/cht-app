// import 'package:cht/models/report.dart';
// import 'package:cht/models/user.dart';
// import 'package:cht/screens/widgets/Data%20visualization/dataContainer.dart';
// import 'package:cht/screens/widgets/Data%20visualization/piechart/index.dart';
// import 'package:cht/screens/widgets/Data%20visualization/progressBars/progressBar.dart';
// import 'package:cht/screens/widgets/Data%20visualization/progressBars/progressBarHorizontal.dart';
// import 'package:cht/util/colorConstants.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class ReportWidget extends StatefulWidget {
//   final ScrollController scrollController;
//   final bool showpin;
//   final double width;
//   final Report report;
//   ReportWidget(
//       {@required this.report,
//       this.showpin = false,
//       @required this.width,
//       this.scrollController})
//       : assert(width != null);
//   @override
//   _ReportWidgetState createState() => _ReportWidgetState(
//       report: report,
//       width: width,
//       scrollController: scrollController,
//       showpin: showpin);
// }

// class _ReportWidgetState extends State<ReportWidget> {
//   ScrollController scrollController;
//   bool showpin;
//   double width;
//   bool loaded = false;
//   Report report;
//   _ReportWidgetState(
//       {this.showpin = false,
//       @required this.report,
//       @required this.width,
//       this.scrollController})
//       : assert(width != null);
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       controller: scrollController,
//       child: Container(
//         width: width,
//         height: 1150,
//         decoration: BoxDecoration(
//             color: AppColors.backgroundColor, //Color(0xff273C5C)
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30), topRight: Radius.circular(30))),
//         child: Column(
//           children: [
//             showpin ? _buildPin() : Container(),
//             SizedBox(
//               height: 20,
//             ),
//             //main progress bar
//             Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: Offset(-14, -14),
//                       spreadRadius: -15),
//                   BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: Offset(10, 10),
//                       spreadRadius: -5),
//                 ],
//               ),
//               child: ProgressBar(
//                 percentage: report.score / 10,
//                 height: 50,
//                 width: width - 50,
//                 backgroundcolor: Color(0xff4572B5),
//               ),
//             ),
//             //main progress bar end
//             SizedBox(
//               height: 10,
//             ),
//             //score
//             Container(
//               width: 100,
//               height: 50,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: Offset(-14, -14),
//                       spreadRadius: -15),
//                   BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: Offset(10, 10),
//                       spreadRadius: -5),
//                 ],
//                 borderRadius: BorderRadius.circular(25),
//                 color: Color(0xff4572B5),
//               ),
//               child: Center(
//                   child: Text(
//                 report.score.toStringAsFixed(2),
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               )),
//             ),
//             //score end
//             SizedBox(
//               height: 10,
//             ),
//             //index stats start
//             //BarChart(BarChartData()),

//             DataContainer(
//               height: 185,
//               width: width - 20,
//               color: Color(0xff122853),
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: report.indexData.length,
//                   reverse: true,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Container(
//                         width: 90,
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ProgressBarH(
//                                 backgroundcolor: Color(0xff4572B5),
//                                 height: 130,
//                                 width: 50,
//                                 percentage: report.indexData[index].value,
//                               ),
//                             ),
//                             Text(
//                               report.indexData[index].name,
//                               style: TextStyle(color: Colors.white),
//                               overflow: TextOverflow.fade,
//                               softWrap: false,
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             //index stats end
//             SizedBox(
//               height: 10,
//             ),
//             //pie chart
//             DataContainer(
//               height: 230,
//               width: width - 20,
//               color: Color(0xff122853),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(18.0),
//                       child: PieChart(PieChartData(sections: [
//                         for (int i = 0; i < report.indexData.length; i++)
//                           PieChartSectionData(
//                             showTitle: false,
//                             color: kPieChartColors[i % 8],
//                             value: report.indexData[i].value == 0
//                                 ? 0.00000001
//                                 : report.indexData[i].value,
//                           )
//                       ])),
//                     ),
//                     flex: 4,
//                   ),
//                   Expanded(
//                     child: Padding(
//                         padding: EdgeInsets.all(20),
//                         child: Index(
//                           data: report.indexData,
//                         )),
//                     flex: 3,
//                   )
//                 ],
//               ),
//             ),
//             //pie chart end
//             SizedBox(
//               height: 20,
//             ),
//             //activity text start
//             DataContainer(
//               height: 230,
//               width: width - 20,
//               color: Color(0xff122853),
//               child: LayoutBuilder(builder: (context, constraints) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                       child: Container(
//                         height: 30,
//                         width: 120,
//                         decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Center(
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.info_outline,
//                                 color: Colors.white,
//                               ),
//                               SizedBox(
//                                 width: 3,
//                               ),
//                               Text(
//                                 "Your Activity",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
//                       child: Container(
//                         height: 140,
//                         width: constraints.maxWidth - 50,
//                         decoration: BoxDecoration(
//                             color: Color(0xff122853),
//                             borderRadius: BorderRadius.circular(20)),
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: report.activityTexts.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: DataContainer(
//                                 color: Color(0xff1e396e),
//                                 height: 130,
//                                 width: constraints.maxWidth - 60,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Center(
//                                     child: Text(
//                                       report.activityTexts[index],
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 15),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     )
//                   ],
//                 );
//               }),
//             ),
//             //some text end
//             SizedBox(
//               height: 20,
//             ),
//             //suggestions start
//             DataContainer(
//               height: 230,
//               width: width - 20,
//               color: Color(0xff122853),
//               child: LayoutBuilder(builder: (context, constraints) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                       child: Container(
//                         height: 30,
//                         width: 120,
//                         decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Center(
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.add_alert_sharp,
//                                 color: Colors.white,
//                               ),
//                               SizedBox(
//                                 width: 3,
//                               ),
//                               Text(
//                                 "Suggestions",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
//                       child: Container(
//                         height: 140,
//                         width: constraints.maxWidth - 50,
//                         decoration: BoxDecoration(
//                             color: Color(0xff122853),
//                             borderRadius: BorderRadius.circular(20)),
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: report.suggestions.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: DataContainer(
//                                 color: Color(0xff1e396e),
//                                 height: 130,
//                                 width: constraints.maxWidth - 60,
//                                 child: Row(children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   Expanded(
//                                     flex: 1,
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Image.network(
//                                         report.suggestions[index].imageUrl,
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   Expanded(
//                                     flex: 3,
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           report.suggestions[index].text,
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 15),
//                                         ),
//                                         Container(
//                                           width: 130,
//                                           height: 30,
//                                           child: ElevatedButton(
//                                               onPressed: () {},
//                                               child: Text(
//                                                 "Learn More..",
//                                                 style: TextStyle(
//                                                     color: Colors.white),
//                                               )),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                 ]),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     )
//                   ],
//                 );
//               }),
//             ),
//             //suggestions end
//             // ElevatedButton(
//             //     onPressed: () {
//             //       _loadallData();
//             //     },
//             //     child: Text("Debug log")),
//           ],
//         ),
//       ),
//     );
//   }

//   Padding _buildPin() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//       child: Container(
//         width: 70,
//         height: 6,
//         decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.4),
//             borderRadius: BorderRadius.circular(3)),
//       ),
//     );
//   }
// }
