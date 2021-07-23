import 'package:flutter/material.dart';

class IndexModel {
  final String name;
  final double value;

  IndexModel({@required this.name, @required this.value});
  @override
  String toString() {
    return "IndexModel($name - $value)";
  }
}
