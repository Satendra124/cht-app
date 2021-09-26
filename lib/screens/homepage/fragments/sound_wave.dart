import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SoundWave extends StatelessWidget {
  const SoundWave(
      {Key key,
      this.waveData,
      this.height,
      this.width,
      this.color,
      this.wavePaint})
      : super(key: key);
  final List<int> waveData;
  final double height;
  final double width;
  final Color color;
  final Paint wavePaint;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        child: Container(),
        painter: SoundWavePainter(
            waveData: waveData, height: height, width: width, color: color),
      ),
    );
  }
}

class SoundWavePainter extends CustomPainter {
  final List<int> waveData;
  final double height;
  final double width;
  final Color color;
  final Paint wavePaint;
  List<double> points;

  SoundWavePainter({
    @required this.waveData,
    @required this.height,
    @required this.width,
    @required this.color,
  })  : wavePaint = new Paint()
          ..color = color.withOpacity(1.0)
          ..style = PaintingStyle.fill,
        assert(waveData != null),
        assert(height != null),
        assert(width != null),
        assert(color != null);

  @override
  void paint(Canvas canvas, Size size) {
    if (waveData != null) {
      double barWidth = width / waveData.length;
      wavePaint.strokeWidth = barWidth;
      int max_amp = waveData.reduce(max);
      for (int i = 0; i < waveData.length; i++) {
        int bytePosition = i;
        double bottom =
            (height / 2 + (((waveData[bytePosition])) / max_amp) * height / 2);
        double top =
            (height / 2 - (((waveData[bytePosition])) / max_amp) * height / 2);
        double barX = (i * barWidth) + (barWidth / 2);
        canvas.drawLine(Offset(barX, height / 2), Offset(barX, top), wavePaint);
        canvas.drawLine(
            Offset(barX, height / 2), Offset(barX, bottom), wavePaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
