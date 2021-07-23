import 'package:cht/models/report.dart';
import 'package:cht/util/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepsWidget extends StatelessWidget {
  final int steps;

  const StepsWidget({Key key, this.steps}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorLight.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Steps",
                style: TextStyle(color: ColorLight.black.withOpacity(0.6)),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                steps.toString(),
                style: TextStyle(
                  color: ColorLight.themeColor,
                  fontFamily: "LukiestGuy",
                  fontSize: 30,
                ),
              ),
            )
          ],
        ));
  }
}
