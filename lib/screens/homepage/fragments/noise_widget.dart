import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';

//TODO:SATISH

///noise widget
/// * args - `datapoints`, `width`, `height`,`yellowThreshold`
/// * return - widget which shows yellow for value with yellow threshold and red spectrum with greater
/// than yellowthreshold and green for lower
/// * refer https://matt.aimonetti.net/posts/2019-07-drawing-waveforms-in-flutter/
class NoiseWidget extends StatelessWidget {
  NoiseWidget({Key key, @required this.datapoints}) : super(key: key);
  final List<double> datapoints;
  // final double redthreshold;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: 200,
      color: Colors.white,
    );
  }
}
