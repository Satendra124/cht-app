import 'dart:math';

import 'package:cht/controllers/home_screen_controller.dart';
import 'package:cht/controllers/report_controller.dart';
import 'package:cht/screens/homepage/widgets/menu.dart';
import 'package:cht/screens/widgets/drawer/homeDrawer.dart';
import 'package:cht/util/AppConstants.dart';
import 'package:cht/util/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:cht/screens/homepage/widgets/activity_bar_graph.dart';
import 'package:cht/screens/homepage/widgets/activity_text_widgets.dart';
import 'package:cht/screens/homepage/widgets/datebar.dart';
import 'package:cht/screens/homepage/widgets/score_widget.dart';
import 'package:cht/screens/homepage/widgets/screen_time_widget.dart';
import 'package:cht/screens/homepage/widgets/sleep_time_widgets.dart';
import 'package:cht/screens/homepage/widgets/suggestions_widgets.dart';
import 'package:cht/screens/homepage/widgets/steps_widget.dart';
import '../../util/ui_helper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  final ReportStateController reportStateController =
      Get.put(ReportStateController());
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff273C5C),
      key: _drawerKey,
      drawer: HomeDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 200,
              left: screenWidth - 340,
              child: Column(
                children: [
                  Icon(
                    Icons.file_download,
                    size: 100,
                    color: ColorLight.white.withOpacity(0.5),
                  ),
                  Text(
                    "Problem Loading Map 😢 , Restart App",
                    style: TextStyle(
                      color: ColorLight.white.withOpacity(0.5),
                    ),
                  )
                ],
              ),
            ),
            MapboxMap(
              compassEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: LatLng(25.265, 82.991), zoom: 13.5),
              onMapCreated: _onMapCreated,
              accessToken: ACCESS_TOKEN,
              myLocationEnabled: true,
              myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
              myLocationRenderMode: MyLocationRenderMode.GPS,
              onMapClick: (point, latLng) async {},
              onMapLongClick: (point, latLng) async {},
              styleString:
                  "mapbox://styles/satendra124/ckmeqkg4ykbjd17o5wu4cw5ym",
            ),
            stepsWidget(),
            DraggableScrollableSheet(
              minChildSize: 105 / screenHeight,
              maxChildSize: 1,
              initialChildSize: 380 / screenHeight,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                          color: ColorLight.themeColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: Wrap(
                        children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Container(
                                width: 70,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Your Activity",
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: "LukiestGuy"),
                                  )
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            DateBar(),
                            SizedBox(
                              height: 20,
                            ),
                            Row(children: [
                              Spacer(),
                              Obx(() => ScoreWidget(
                                    score: reportStateController
                                        .report.value.score,
                                  )),
                              Spacer(),
                              Obx(() => StepsWidget(
                                    steps: reportStateController
                                        .report.value.steps,
                                  )),
                              Spacer()
                            ]),
                            SizedBox(height: 20),
                            Obx(() => ActivityBarGraph(
                                  indexData: reportStateController
                                      .report.value.indexHours,
                                )),
                            SizedBox(height: 20),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Obx(() => ScreenTimeWidget(
                                        screenTime: reportStateController
                                            .report.value.screenTime,
                                      )),
                                  Obx(() => SleepTimeWidget(
                                        sleepTime: reportStateController
                                            .report.value.sleepTime,
                                      ))
                                ]),
                            SizedBox(height: 20),
                            Obx(() => ActivityTextWidget(
                                  activityTexts: reportStateController
                                      .report.value.activityIndexDiscriptions,
                                )),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  "Suggestions",
                                  style: TextStyle(
                                    fontFamily: "LukiestGuy",
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Obx(() => Column(
                                  children: reportStateController
                                      .report.value.suggestions
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SuggestionWidget(
                                              suggestion: e,
                                            ),
                                          ))
                                      .toList(),
                                )),
                            SizedBox(height: 20)
                          ])
                        ],
                      ),
                    ));
              },
            ),
            _menuButton(),
            Obx(() => Container(
                  child: homeScreenController.menuState.value == MenuState.Open
                      ? Menu()
                      : Container(),
                ))
          ],
        ),
      ),
    );
  }

  Positioned stepsWidget() {
    return Positioned(
      top: 50,
      right: 0,
      child: Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
          color: ColorLight.materialBackground,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
        ),
        child: Row(
          children: [
            Spacer(),
            Obx(() => Text(
                  reportStateController.report.value.steps.toString(),
                  style: TextStyle(
                    color: ColorLight.black,
                    fontSize: 30,
                    fontFamily: "OpenSans",
                  ),
                )),
            Spacer(),
            Transform.rotate(
              angle: 3 * pi / 2,
              child: Text(
                "Steps",
                style: TextStyle(color: ColorLight.black.withOpacity(0.5)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned _menuButton() {
    return Positioned(
      top: 25,
      left: 10,
      child: Container(
        width: 60,
        height: 60,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () async {
              homeScreenController.openCloseMenu();
            },
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.network(
                    AppConstants.curUser.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
      ),
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }
}
