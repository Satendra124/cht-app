import 'package:cht/data/generator.dart';
import 'package:cht/models/report_model.dart';
import 'package:get/get.dart';

class ReportDataController extends GetxController {
  Rx<DataState> datastate = DataState.notstarted.obs;
  Rx<ReportDateRangeType> dateRange = ReportDateRangeType.today.obs;
  Rx<Report> report = Report().obs;
  @override
  void onInit() {
    updateReport();
    datastate.listen((p0) {
      print(p0);
    });
    super.onInit();
  }

  void updateReport() async {
    this.datastate.value = DataState.loading;
    Generator generator = new Generator();
    DateTime end = DateTime.now();
    if (dateRange.value == ReportDateRangeType.today)
      end.subtract(Duration(days: 1));
    else if (dateRange.value == ReportDateRangeType.last7days)
      end.subtract(Duration(days: 7));
    else
      end.subtract(Duration(days: 30));
    this.report.value = await generator.generateReport(
      DateTime.now(),
      end,
    );
    this.datastate.value = DataState.completed;
  }
}

enum DataState { notstarted, loading, completed }

class ReportDateRange {
  final DateTime start;
  final DateTime end;
  final ReportDateRangeType reportDateRangeType;
  ReportDateRange(this.start, this.end, this.reportDateRangeType);
}

enum ReportDateRangeType { today, last7days, last30days }
