import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class UserReaction extends StatefulWidget {
  @override
  _UserReactionState createState() => _UserReactionState();
}

class _UserReactionState extends State<UserReaction> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        height:
            math.max(250, screenHeight * 0.3), //TODO : check for correct values
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFE1BEE7),
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 13), // TODO : check for correct values for screen sizes
            child: Column(
              children: <Widget>[
                Container(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                  child: Container(
                    height: 30.0,
                    child: Center(
                      child: Text(
                        'How are you feeling right now?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                  ),
                )),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35.0, bottom: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _emoji_widget('😃'),
                        _emoji_widget('😨'),
                        _emoji_widget('😡'),
                        _emoji_widget('😌'),
                        _emoji_widget('😣'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

// TODO: register user reaction on tap and hide for an hour
  Widget _emoji_widget(String emojiString) {
    return Text(
      emojiString,
      style: TextStyle(
        fontSize: 35,
      ),
    );
  }
}
