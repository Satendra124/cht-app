import 'dart:math';

import 'package:cht/models/index.dart';
import 'package:cht/screens/widgets/Data visualization/piechart/piechart.dart';
import 'package:flutter/material.dart';

class PieChartDraw extends CustomPainter {
  PieChartDraw({@required this.indexs, @required this.width});

  final List<IndexModel> indexs;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    // Calculate total amount from each category
    indexs.forEach((expense) => total += expense.value);

    // The angle/radian at 12 o'clcok
    double startRadian = -pi / 2;

    for (var index = 0; index < indexs.length; index++) {
      final currentCategory = indexs.elementAt(index);
      // Amount of length to paint is a percentage of the perimeter of a circle (2 x pi)
      final sweepRadian = currentCategory.value / total * 2 * pi;
      // Used modulo/remainder to catch use case if there is more than 6 colours
      paint.color = kPieChartColors.elementAt(index % 8);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );
      // The new startRadian starts from where the previous sweepRadian.
      // Example, a circle perimeter is 10.
      // Category A takes a startRadian 0 and ends at sweepRadian 5.
      // Category B takes the startRadian where Category A left off, which is 5
      // and ends at sweepRadian 7.
      // Category C takes the startRadian where Category B left off, which is 7
      // and so on.
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
