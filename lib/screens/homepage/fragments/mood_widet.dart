import 'package:flutter/material.dart';
import 'package:cht/models/report_model.dart';

//TODO:SATISH

///improve widget to make more moduler
///see [user_reaction.dart]
/// * args - List<[MoodInfo]>,width,height
/// * return widget
class MoodsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        // width: screenWidth - 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Moods Today",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
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
        ]));
  }
}
