import 'package:cht/models/report.dart';
import 'package:cht/util/colorConstants.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';

class ActivityTextWidget extends StatelessWidget {
  final List<ActivityIndexDiscriptions> activityTexts;

  const ActivityTextWidget({Key key, @required this.activityTexts})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        //height: 200,
        width: screenWidth - 50,
        decoration: BoxDecoration(
          color: ColorLight.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Report",
                    style: TextStyle(color: ColorLight.black.withOpacity(0.6)),
                  ),
                ),
              ] +
              activityTexts.map((e) => activityText(e)).toList() +
              [
                SizedBox(
                  height: 20,
                )
              ],
        ),
      ),
    );
  }

  Widget activityText(ActivityIndexDiscriptions activity) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        activity.text,
        style: TextStyle(
          color: ColorLight.black,
        ),
      ),
    );
  }
}
