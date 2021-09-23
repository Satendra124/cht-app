import 'package:cht/controllers/home_screen_controller.dart';
import 'package:cht/controllers/report_controller.dart';
import 'package:cht/screens/homepage/user_reaction.dart';
import 'package:cht/screens/homepage/widgets/menu.dart';
import 'package:cht/util/AppConstants.dart';
import 'package:cht/util/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../../util/ui_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final ReportStateController reportStateController =
      Get.put(ReportStateController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //This error is shown if map fails to load
            _map_error_widget(),
            // main mapbox map
            _main_map(),

            // |----------User reactions------------------|
            UserReaction(),
            //menu botton to toggle menu
            _menuButton(),
            // |--------------Menu start----------------|
            Obx(() => Container(
                  child: homeScreenController.menuState.value == MenuState.Open
                      ? Menu()
                      : Container(),
                ))
            // |---------------Menu End----------------|
          ],
        ),
      ),
    );
  }

  MapboxMap _main_map() {
    return MapboxMap(
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
      styleString: "mapbox://styles/satendra124/ckmeqkg4ykbjd17o5wu4cw5ym",
    );
  }

//TODO: remove hardcoded top and left
  Positioned _map_error_widget() {
    return Positioned(
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
    );
  }

  // -XXXXXXXXXXXXXXXXXXXX Archived - steps -XXXXXXXXXXXXXXXXXXX
  /*
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
*/
// TODO: can cause error in loading image (show a deafult image when load failed)
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
                  child: AppConstants.curUser != null
                      ? Image.network(
                          AppConstants.curUser.photoUrl,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.account_circle_rounded),
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
