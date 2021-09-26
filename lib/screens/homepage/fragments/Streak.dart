import 'package:flutter/material.dart';

class Streak extends StatelessWidget {
  final int streakDays;

  const Streak({Key key, this.streakDays}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 110,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.assistant_photo_rounded,
                  color: Colors.white,
                ),
                Text(
                  streakDays.toString() + ' days',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
        )
      ],
    );
  }
}
