import 'package:cht/controllers/home_screen_controller.dart';
import 'package:cht/util/AppConstants.dart';
import 'package:cht/util/colorConstants.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatelessWidget {
  final HomeScreenController homeScreenController =
      Get.find<HomeScreenController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: ColorLight.white,
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: ColorLight.black,
                ),
                onPressed: () {
                  homeScreenController.openCloseMenu();
                }),
          ),
          Column(
            children: [
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: _dp(),
              ),
              SizedBox(height: 10),
              Text(
                AppConstants.curUser.name,
                style: TextStyle(
                  color: ColorLight.themeColor,
                  fontFamily: "LukiestGuy",
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 4),
              Text(
                AppConstants.curUser.email,
                style: TextStyle(
                  color: ColorLight.black,
                  fontFamily: "OpenSans",
                  fontSize: 10,
                ),
              ),
              SizedBox(height: 40),
              MenuItem(icon: Icons.home, text: "Home"),
              // SizedBox(height: 10),
              // MenuItem(icon: Icons.calendar_today, text: "Report"),
              // SizedBox(height: 10),
              // MenuItem(icon: Icons.settings, text: "Settings"),
              // SizedBox(height: 10),
              MenuItem(icon: Icons.info, text: "Info"),
              SizedBox(height: 10),
              Spacer()
            ],
          )
        ],
      ),
    );
  }

  ClipRRect _dp() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          AppConstants.curUser.photoUrl,
          height: 100,
          width: 100,
        ));
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const MenuItem({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 40,
            color: ColorLight.black,
          ),
        ),
        SizedBox(width: 20),
        Text(
          text,
          style: TextStyle(
            color: ColorLight.black,
            fontFamily: "LukiestGuy",
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
