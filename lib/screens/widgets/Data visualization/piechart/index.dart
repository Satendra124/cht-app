import 'package:cht/models/index.dart';
import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  final List<IndexModel> data;

  const Index({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: kPieChartColors[index % 8]),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  data[index].name,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        );
      },
    ));
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
