import 'package:cht/controllers/report_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:cht/models/report_model.dart';
import 'package:get/get.dart';

///improve widget to make more moduler
///see [user_reaction.dart]
/// * args - List<[Mood]>,width,height
/// * return widget

class MoodsWidget extends StatelessWidget {
  final double width;
  final double height;
  final Map<Mood, int> moods;
  static const Map<Mood, String> mood_to_emoji = {
    Mood.angry: '😡',
    Mood.calm: '😌',
    Mood.happy: '😃',
    Mood.sad: '😣',
    Mood.scared: '😨',
  };

  static const Map<Mood, String> mood_to_text = {
    Mood.angry: 'Angry',
    Mood.calm: 'Calm',
    Mood.happy: 'Happy',
    Mood.sad: 'Sad',
    Mood.scared: 'Scared',
  };
  MoodsWidget(
      {Key key,
      @required this.width,
      @required this.height,
      @required this.moods})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _label(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _emojiCounter(Mood.happy),
                _emojiCounter(Mood.calm),
                _emojiCounter(Mood.sad),
                _emojiCounter(Mood.scared),
                _emojiCounter(Mood.angry),
              ],
            ),
          ],
        ));
  }

  Padding _label() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Moods",
          style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _emojiCounter(Mood moodType) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            mood_to_emoji[moodType],
            style: TextStyle(fontSize: 30),
          ),
        ),
        Container(
          child: Center(child: Text(moods[moodType].toString())),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.purple.withOpacity(0.5)),
          width: 30,
          height: 30,
        ),
        Text(
          mood_to_text[moodType],
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}


/** 
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 0.0),
              child: Row(
                children: [
                  Text(
                    '😃',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                  Text(
                    '😨',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                  Text(
                    '😡',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                  Text(
                    '😌',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                  Text(
                    '😣',
                    style: TextStyle(
                      fontSize: 30,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 24.0,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 10.0),
              child: Row(
                children: [
                  Text(
                    'Happy',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 26.0,
                  ),
                  Text(
                    'Scared',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 26.0,
                  ),
                  Text(
                    'Angry',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 33.0,
                  ),
                  Text(
                    'Calm',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  Text(
                    'Sad',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold
                        // fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    width: 26.0,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 10.0),
              child: Row(
                children: [
                  Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11.0, top: 6.0),
                      child: Text(
                        '1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 26.0,
                  ),
                  Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11.0, top: 6.0),
                      child: Text(
                        '5',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 28.0,
                  ),
                  Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11.0, top: 6.0),
                      child: Text(
                        '0',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 32.0,
                  ),
                  Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11.0, top: 6.0),
                      child: Text(
                        '3',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                  Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11.0, top: 6.0),
                      child: Text(
                        '2',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        
 */