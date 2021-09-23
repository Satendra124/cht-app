import 'package:cht/controllers/report_data_controller.dart';
import 'package:cht/screens/homepage/fragments/mood_widet.dart';
import 'package:cht/screens/homepage/fragments/noise_widget.dart';
import 'package:cht/screens/homepage/fragments/places_widget.dart';
import 'package:cht/screens/homepage/fragments/sleep_widget.dart';
import 'package:cht/screens/homepage/fragments/steps_widget.dart';
import 'package:cht/screens/homepage/fragments/usage_data.dart';
import 'package:cht/screens/homepage/home.dart';
import 'package:cht/screens/homepage/plugin/draggable_bottom_sheet.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomStatsSheet extends StatefulWidget {
  @override
  _BottomStatsSheetState createState() => _BottomStatsSheetState();
}

class _BottomStatsSheetState extends State<BottomStatsSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableBottomSheet(
        backgroundWidget: HomePage(),
        minExtent: 150,
        maxExtent: screenHeight,
        expansionExtent: 150,
        expandedChild: ExpandedActivityView(),
        previewChild: ColapsedActivityView(),
      ),
    );
  }
}

class ExpandedActivityView extends StatelessWidget {
  final ReportDataController reportDataController =
      Get.put(ReportDataController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(
        color: Colors.purple,
      ),
      child: Column(children: [
        _pin(),
        SizedBox(height: 20),
        Text(
          "Your Activity",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 10),
        DateBar(initialSelection: reportDataController.dateRange.value),
        SizedBox(height: 20),
        ActivityDataView(),
      ]),
    );
  }

  Padding _pin() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
        width: 70,
        height: 6,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}

class DateBar extends StatelessWidget {
  final ReportDateRangeType initialSelection;
  final ReportDataController reportDataController = Get.find();
  DateBar({Key key, this.initialSelection}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Padding(
          padding: EdgeInsets.only(right: 0.0, left: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _dateButton(ReportDateRangeType.today),
              _dateButton(ReportDateRangeType.last7days),
              _dateButton(ReportDateRangeType.last30days),
            ],
          ),
        ));
  }

//TODO: Can add animation with [AnimatedOpacity]
  Widget _dateButton(ReportDateRangeType daterange) {
    DateTime today = DateTime.now();
    Map<ReportDateRangeType, String> dateRangeText = {
      ReportDateRangeType.today: "Today, " + today.day.toString() + "th",
      ReportDateRangeType.last7days: "This Week",
      ReportDateRangeType.last30days: "This Month",
    };
    return Obx(() => ElevatedButton(
          onPressed: () async {
            print(reportDataController.datastate.value);
            if (reportDataController.datastate.value == DataState.loading)
              return;
            reportDataController.datastate.value = DataState.loading;
            reportDataController.dateRange.value = daterange;
            reportDataController.updateReport();
          },
          child: Text(
            dateRangeText[daterange],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.white.withOpacity(
                daterange == reportDataController.dateRange.value ? 0.5 : 0.3),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.purple)),
          ),
        ));
  }
}

class ActivityDataView extends StatelessWidget {
  final ReportDataController reportDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<Widget> statsWidgets = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(() => StepsWidget(
                height: 100,
                steps: reportDataController.report.value.steps,
                width: 150,
              )),
          Obx(() => SleepWidget(
                height: 100,
                sleepTime: reportDataController.report.value.sleepTime,
                width: 150,
              )),
        ],
      ),
      MoodsWidget(),
      NoiseWidget(datapoints: [121, 211, 123, 1231]),
      UsageWidget(),
      PlacesWidget()
    ];
    return Obx(() {
      if (reportDataController.datastate.value == DataState.completed) {
        return Expanded(
          child: ListView.builder(
            itemCount: statsWidgets.length,
            // gridDelegate:
            //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: statsWidgets[index],
              );
            },
          ),
        );
      } else if (reportDataController.datastate.value == DataState.loading) {
        return CircularProgressIndicator();
      } else
        return Icon(
          Icons.cancel,
          color: Colors.red,
        );
    });
  }
}

//TODO:SATISH
class ColapsedActivityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.purple,
      width: screenWidth,
      child: Center(
        child: Text("Pull"),
      ),
    );
  }
}

class LoadingActivityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
