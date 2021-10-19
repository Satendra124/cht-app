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
    int green = 255;
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backgroundcolor,
          ),
        ),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          height: height,
          width: width * percentage,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, green, 0, 1),
          ),
        ),
      ],
    );
  }
}
