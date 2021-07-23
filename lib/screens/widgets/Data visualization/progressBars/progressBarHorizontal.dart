import 'package:flutter/material.dart';

class ProgressBarH extends StatelessWidget {
  double percentage;
  final double width;
  final double height;
  final Color backgroundcolor;
  ProgressBarH(
      {this.percentage, this.height, this.width, this.backgroundcolor});
  @override
  Widget build(BuildContext context) {
    percentage *= 2;
    if (percentage > 1) percentage = 1;
    if (percentage <= 0) percentage = 0.01;
    int red = 255;
    int green = 255;
    if (percentage >= 0 && percentage <= 0.5) {
      green = (510 * percentage).floor();
    } else if (percentage > 0.5 && percentage <= 1) {
      red = (-510 * percentage + 510).floor();
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
        Positioned(
          bottom: 0,
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            height: percentage > 0.1 ? height * percentage : height * 0.1,
            width: width,
            decoration: BoxDecoration(
                color: Color.fromRGBO(red, green, 0, 1),
                borderRadius: BorderRadius.circular(height / 2)),
          ),
        ),
      ],
    );
  }
}
