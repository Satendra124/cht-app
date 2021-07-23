import 'package:cht/controllers/report_controller.dart';
import 'package:cht/util/colorConstants.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateBar extends StatelessWidget {
  final ReportStateController reportController =
      Get.find<ReportStateController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              DateTime date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime.now());
              reportController.changeDate(date);
            },
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorLight.white.withOpacity(0.2),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Obx(() => Text(reportController.date.value.day.toString() +
                  "/" +
                  reportController.date.value.month.toString() +
                  "/" +
                  reportController.date.value.year.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
