import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  double percentage;
  final double width;
  final double height;
  final Color backgroundcolor;
  ProgressBar({this.percentage, this.height, this.width, this.backgroundcolor});
  @override
  Widget build(BuildContext context) {
    percentage = percentage > 0 ? percentage : 0.1;
    int red = 255;
    int green = 255;
    if (percentage >= 0 && percentage <= 0.5) {
      red = (510 * percentage).floor();
    } else if (percentage > 0.5 && percentage <= 1) {
      green = (-510 * percentage + 510).floor();
    }
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: backgroundcolor,
              borderRadius: BorderRadius.circular(height / 2)),
        ),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          height: height,
          width: width * percentage,
          decoration: BoxDecoration(
              color: Color.fromRGBO(red, green, 0, 1),
              borderRadius: BorderRadius.circular(height / 2)),
        ),
      ],
    );
  }
}
