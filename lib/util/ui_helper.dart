import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

double screenWidth;
double screenHeight;
MapboxMapController mapController;
LatLng selectedpin;
String ACCESS_TOKEN =
    "pk.eyJ1Ijoic2F0ZW5kcmExMjQiLCJhIjoiY2tsbDNvaWZuMTM1NDJwbm1pZWZtZmt2ZSJ9.LbmaxYdRppOSYsS3kU0SOQ";

Widget dataTableFromData(List<Map<String, Object>> data) {
  if (data.length == 0) return Text("NO Data");
  List<DataColumn> cols = data[0]
      .keys
      .map((e) =>
          DataColumn(label: Text(e, style: TextStyle(color: Colors.white))))
      .toList();
  List<DataRow> rows = data.map((rowData) {
    List<String> keys = rowData.keys.toList();
    List<DataCell> cells = [
      for (String key in keys)
        DataCell(Text(
          rowData[key].toString(),
          style: TextStyle(color: Colors.white),
        ))
    ];
    return DataRow(cells: cells);
  }).toList();
  return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(columns: cols, rows: rows)));
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
