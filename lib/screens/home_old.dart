// import 'package:cht/models/user.dart';
// import 'package:cht/screens/admin.dart';
// import 'package:cht/screens/widgets/drawer/homeDrawer.dart';
// import 'package:cht/screens/widgets/report/reportWidget.dart';
// import 'package:cht/services/DatabaseService.dart';
// import 'package:cht/services/ReportService.dart';
// import 'package:cht/util/colorConstants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

// import '../util/ui_helper.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
//   DateTime today = DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     Future<Report> report = ReportService().getReport(
//         DateTime.utc(today.year, today.month, today.day),
//         DateTime.utc(today.year, today.month, today.day + 1));
//     return Scaffold(
//       //backgroundColor: Color(0xff273C5C),
//       key: _drawerKey,
//       drawer: HomeDrawer(),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             MapboxMap(
//               compassEnabled: true,
//               initialCameraPosition:
//                   CameraPosition(target: LatLng(25.265, 82.991), zoom: 13.5),
//               onMapCreated: _onMapCreated,
//               accessToken: ACCESS_TOKEN,
//               myLocationEnabled: true,
//               myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
//               myLocationRenderMode: MyLocationRenderMode.GPS,
//               onMapClick: (point, latLng) async {},
//               onMapLongClick: (point, latLng) async {},
//               styleString:
//                   "mapbox://styles/satendra124/ckmeqkg4ykbjd17o5wu4cw5ym",
//             ),
//             Positioned(
//               top: 25,
//               left: 10,
//               child: Container(
//                 width: 60,
//                 height: 60,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(35))),
//                     onPressed: () async {
//                       _drawerKey.currentState.openDrawer();
//                     },
//                     child: Center(
//                       child: Icon(
//                         Icons.menu,
//                         color: Colors.black,
//                       ),
//                     )),
//               ),
//             ),
//             Positioned(
//               top: 25,
//               left: 10,
//               child: Container(
//                 width: 60,
//                 height: 60,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(35))),
//                     onPressed: () async {
//                       // const MethodChannel _channel =
//                       //     const MethodChannel('service_channel');
//                       // double amp = await _channel.invokeMethod("getAmplitude");
//                       // ScaffoldMessenger.of(context).showSnackBar(
//                       //     SnackBar(content: Text(amp.toString() + " Db")));
//                       String firebaseIdToken =
//                           await FirebaseAuth.instance.currentUser.getIdToken();
//                       while (firebaseIdToken.length > 0) {
//                         int startTokenLength = (firebaseIdToken.length >= 300
//                             ? 300
//                             : firebaseIdToken.length);
//                         print("TokenPart: " +
//                             firebaseIdToken.substring(0, startTokenLength));
//                         int lastTokenLength = firebaseIdToken.length;
//                         firebaseIdToken = firebaseIdToken.substring(
//                             startTokenLength, lastTokenLength);
//                       }
//                       // print(
//                       //     await FirebaseAuth.instance.currentUser.getIdToken());
//                     },
//                     child: Center(
//                       child: Icon(
//                         Icons.ac_unit,
//                         color: Colors.black,
//                       ),
//                     )),
//               ),
//             ),
//             Positioned(
//               top: 100,
//               left: 10,
//               child: Container(
//                 width: 60,
//                 height: 60,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         primary: AppColors.backgroundColor,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(35))),
//                     onPressed: () async {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (c) => AdminScreen()));
//                     },
//                     child: Center(
//                       child: Icon(
//                         Icons.admin_panel_settings,
//                         color: AppColors.thirdColor,
//                       ),
//                     )),
//               ),
//             ),
//             DraggableScrollableSheet(
//               minChildSize: 105 / screenHeight,
//               maxChildSize: 1,
//               initialChildSize: 380 / screenHeight,
//               builder: (context, scrollController) {
//                 return FutureBuilder(
//                     future: report,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData)
//                         return ReportWidget(
//                           report: snapshot.data,
//                           width: screenWidth,
//                           scrollController: scrollController,
//                           showpin: true,
//                         );
//                       else
//                         return Container(
//                           child: Center(
//                             child: CircularProgressIndicator(),
//                           ),
//                         );
//                     });
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void _onMapCreated(MapboxMapController controller) {
//     mapController = controller;
//   }

//   void _loadallData() async {
//     print((await DatabaseService.db.getallData(DateTime.now())).toString());
//   }
// }
