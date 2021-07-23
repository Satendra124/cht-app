import 'package:flutter/material.dart';

class DataContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Widget child;

  const DataContainer(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.color,
      @required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: color,
            blurRadius: 10,
            offset: Offset(-14, -14),
            spreadRadius: -15),
        BoxShadow(
            color: color,
            blurRadius: 10,
            offset: Offset(10, 10),
            spreadRadius: -5),
      ], color: color, borderRadius: BorderRadius.circular(20)),
      child: child,
    );
  }
}
