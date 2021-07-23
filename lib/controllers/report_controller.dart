import 'package:cht/models/report.dart';
import 'package:cht/util/AppConstants.dart';
import 'package:get/get.dart';
import 'package:cht/data/post_api_service.dart';

class ReportStateController extends GetxController {
  final Rx<DateTime> date = DateTime.now().obs;
  final Rx<Report> report = Report(0.0, [], [], [], 0, Duration(days: 0),
          Duration(days: 0), DateTime.now())
      .obs;
  @override
  void onInit() async {
    this.report.value =
        await PostApiService().getReport(AppConstants.curUser.uid, date.value);
    super.onInit();
  }

  void changeDate(DateTime date) async {
    this.date.value = date;
    this.report.value =
        await PostApiService().getReport(AppConstants.curUser.uid, date);
  }
}
