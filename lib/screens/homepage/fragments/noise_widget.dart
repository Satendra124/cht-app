import 'package:cht/screens/homepage/fragments/sound_wave.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';

///noise widget
/// * args - `datapoints`, `width`, `height`,`yellowThreshold`
/// * return - widget which shows yellow for value with yellow threshold and red spectrum with greater
/// than yellowthreshold and green for lower
/// * refer https://matt.aimonetti.net/posts/2019-07-drawing-waveforms-in-flutter/
class NoiseWidget extends StatelessWidget {
  NoiseWidget({Key key, @required this.datapoints}) : super(key: key);
  final List<int> datapoints;
  // final double redthreshold;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      width: screenWidth,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _label(),
          SoundWave(
            color: Colors.purple,
            height: 120,
            waveData: datapoints,
            width: screenWidth - 50,
          ),
        ],
      ),
    );
  }

  Padding _label() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Sounds",
          style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
