import 'package:flutter/material.dart';

class StepsWidget extends StatelessWidget {
  final double height;
  final double width;
  final int steps;

  const StepsWidget(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.steps})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Steps",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.directions_walk_rounded,
                color: Colors.purple,
                size: 30.0,
              )
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              steps.toString(),
              style: TextStyle(
                color: Colors.purple,
                fontFamily: "LukiestGuy",
                fontSize: 30,
              ),
            ),
          ),
        ]));
  }
}
