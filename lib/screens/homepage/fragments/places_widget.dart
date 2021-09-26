import 'package:cht/screens/homepage/fragments/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:cht/models/report_model.dart';

/// Implement places widget
/// * args - List<[LocationInfo]> locationInfo, width, height
/// * return widget with [ListView] as given in UI
class PlacesWidget extends StatelessWidget {
  final double height;
  final double width;
  final List<LocationInfo> locationInfoList;
  const PlacesWidget({
    Key key,
    @required this.height,
    @required this.width,
    @required this.locationInfoList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // height: height,
      // width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
                _label(),
              ] +
              locationInfoList
                  .map((LocationInfo e) => _locationInfo(e))
                  .toList()),
    );
  }

  Widget _label() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Places Visited",
          style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _locationInfo(LocationInfo locationInfo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: (height - 50) / locationInfoList.length,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(locationInfo.imageUrl),
            ProgressBar(
              backgroundcolor: Colors.purple,
              height: 30,
              width: 200,
              percentage: locationInfo.ratioTime,
            )
          ],
        ),
      ),
    );
  }
}
