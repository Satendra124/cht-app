import 'package:cht/models/index.dart';
import 'package:cht/screens/widgets/Data visualization/piechart/piechart_draw.dart';
import 'package:flutter/material.dart';

class PieChart extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Color colorNueupper;
  final Color colorNuelower;
  final List<IndexModel> data;
  final double score;
  PieChart(
      {@required this.height,
      @required this.width,
      @required this.data,
      @required this.color,
      @required this.colorNueupper,
      @required this.colorNuelower,
      this.score});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              spreadRadius: -10,
              blurRadius: 17,
              offset: Offset(-5, -5),
              color: colorNueupper,
            ),
            BoxShadow(
              spreadRadius: -2,
              blurRadius: 10,
              offset: Offset(7, 7),
              color: colorNuelower,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: CustomPaint(
              child: Center(
                  child: Text(
                score.toStringAsFixed(2),
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
              foregroundPainter: PieChartDraw(indexs: data, width: width / 3),
            ),
            decoration: BoxDecoration(shape: BoxShape.circle),
          ),
        ),
      )),
    );
  }
}

List<Color> kPieChartColors = [
  Color(0xff003f5c),
  Color(0xff2f4b7c),
  Color(0xff665191),
  Color(0xffa05195),
  Color(0xffd45087),
  Color(0xfff95d6a),
  Color(0xffff7c43),
  Color(0xffffa600),
];
