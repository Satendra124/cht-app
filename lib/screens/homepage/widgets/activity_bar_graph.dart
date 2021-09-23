import 'dart:collection';

import 'package:cht/models/report.dart';
import 'package:cht/util/colorConstants.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ActivityBarGraph extends StatelessWidget {
  final List<IndexData> indexData;

  const ActivityBarGraph({Key key, @required this.indexData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<String, double> pieChartdata = new HashMap();
    bool hasData = false;
    indexData.forEach((element) {
      hasData = true;
      pieChartdata[element.name] = element.duration.inMinutes / 60;
    });
    return Container(
      height: 200,
      width: screenWidth - 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorLight.materialBackground),
      child: hasData
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: PieChart(
                legendOptions: LegendOptions(
                    legendTextStyle: TextStyle(
                  color: ColorLight.black,
                  fontSize: 10,
                )),
                dataMap: pieChartdata,
                animationDuration: Duration(milliseconds: 500),
                centerText: "hr/24hr",
              ),
            )
          : Container(),
    );
  }
}
