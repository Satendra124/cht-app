import 'package:flutter/material.dart';
import 'package:cht/models/report_model.dart';

//TODO:SATISH
/// Implement places widget
/// * args - List<[LocationInfo]> locationinfo, width, height
/// * return widget with [ListView] as given in UI
class PlacesWidget extends StatelessWidget {
  const PlacesWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      // width: screenWidth - 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
    );
  }
}
