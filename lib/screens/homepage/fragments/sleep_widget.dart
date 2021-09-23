import 'package:flutter/material.dart';

class SleepWidget extends StatelessWidget {
  final Duration sleepTime;
  final double height;
  final double width;

  const SleepWidget(
      {Key key,
      @required this.sleepTime,
      @required this.height,
      @required this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sleep",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 60.0,
                ),
                Icon(
                  Icons.mode_night,
                  color: Colors.purple,
                  size: 20.0,
                )
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                sleepTime.inHours.toString() +
                    ":" +
                    (sleepTime.inMinutes - sleepTime.inHours * 60).toString(),
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 25,
                ),
              ),
            ),
            Text(
              'hrs',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6), fontSize: 14.0),
            ),
          ],
        ));
  }
}
