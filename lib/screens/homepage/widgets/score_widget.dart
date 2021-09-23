import 'dart:ffi';

import 'package:cht/models/report.dart';
import 'package:cht/util/colorConstants.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreWidget extends StatelessWidget {
  final double score;

  const ScoreWidget({Key key, @required this.score}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          color: ColorLight.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Score",
                style: TextStyle(color: ColorLight.black.withOpacity(0.6)),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                format(score),
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

String format(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
}
