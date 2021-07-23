//Algorithms not very correct
import 'package:cht/models/index.dart';
import 'package:cht/models/user.dart';
import 'package:cht/services/DatabaseService.dart';
import 'package:cht/test/randGen.dart';
import 'package:cht/util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportService {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  Future<List<LocationHistoryLite>> fetchLocationHistoryLite() async {
    QuerySnapshot reportDataList = await db
        .collection("users")
        .doc("sd") //TODO
        .collection("locationHistory")
        .orderBy("time", descending: false)
        .where("time", isLessThanOrEqualTo: DateTime.now())
        .get();
    List<LocationHistoryLite> toRet = [];
    for (QueryDocumentSnapshot ReportData in reportDataList.docs) {
      if (toRet.length > 0 && ReportData.data()["place"] == toRet.last.place) {
        toRet.last.end = ReportData.data()["time"].toDate();
      } else {
        toRet.add(new LocationHistoryLite(
            place: ReportData.data()["place"],
            start: ReportData.data()["time"].toDate()));
      }
    }

    return toRet.reversed.toList();
  }

  // Future<Map<String, dynamic>> getTodayReport() async {
  //   Map<String, dynamic> report = {
  //     "score": 10.0,
  //     "indexData": <IndexModel>[],
  //     "activityTexts": <String>[],
  //     "suggestions": <SuggestionModel>[],
  //   };
  //   Map<String, double> timeInEachIndex = new Map<String, double>();
  //   for (String index in kIndexNames) {
  //     timeInEachIndex[index] = 0;
  //   }

  //   List<Map<String, dynamic>> todayRawData =
  //       await DatabaseService.db.getReportDataFromLocal();
  //   for (Map<String, dynamic> activity in todayRawData) {
  //     print(activity['index_name']);
  //     Duration timeinI = DateTime.parse(activity['time_end'])
  //         .difference(DateTime.parse(activity['time_start']));
  //     timeInEachIndex[activity['index_name']] +=
  //         (timeinI.inHours + timeinI.inMinutes / 60);
  //   }
  //   String placeHolderUrl =
  //       "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHw%3D&w=1000&q=80";
  //   for (String index in kIndexNames) {
  //     double cip = (2 - timeInEachIndex[index]) / 24; //curent index penalty
  //     report["score"] -= (cip).abs();
  //     report["indexData"]
  //         .add(IndexModel(name: index, value: timeInEachIndex[index]));

  //     if (cip > 1 / 24) {
  //       report["activityTexts"].add("Spending too less time in $index");
  //       report["suggestions"].add(SuggestionModel(
  //           text: "Some suggestion to spend more time in $index",
  //           imageUrl: placeHolderUrl,
  //           knowMoreUrl: placeHolderUrl));
  //     } else if (cip < -1 / 24) {
  //       report["activityTexts"].add("Spending too Much time in $index");
  //       report["suggestions"].add(SuggestionModel(
  //           text: "Some suggestion to spend less time in $index",
  //           imageUrl: placeHolderUrl,
  //           knowMoreUrl: placeHolderUrl));
  //     }
  //   }

  //   report["indexData"]
  //       .sort((IndexModel a, IndexModel b) => a.value > b.value ? 0 : 1);
  //   return report;
  // }

  // Future<Report> getReport(DateTime start, DateTime end) async {
  //   int total =
  //       (start.difference(end).inHours).abs(); //total hours covered in report
  //   Report report = new Report();
  //   Map<String, double> timeInEachIndex = new Map<String, double>();
  //   for (String index in kIndexNames) {
  //     timeInEachIndex[index] = 0;
  //   }

  //   List<Map<String, dynamic>> todayRawData = Constants.TEST_MODE
  //       ? Generator().generateColumn(start, end)
  //       : await DatabaseService.db.getLocationDataFromLocalDB(start, end);
  //   //print(todayRawData);
  //   for (Map<String, dynamic> activity in todayRawData) {
  //     //print(activity['index_name']);
  //     Duration timeinI = DateTime.parse(activity['time_end'])
  //         .difference(DateTime.parse(activity['time_start']));
  //     timeInEachIndex[activity['index_name']] +=
  //         (timeinI.inHours + timeinI.inMinutes / 60);
  //   }
  //   String placeHolderUrl =
  //       "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHw%3D&w=1000&q=80";
  //   for (String index in kIndexNames) {
  //     double cip =
  //         (48 / total - timeInEachIndex[index]) / total; //curent index penalty
  //     report.score -= (cip).abs();
  //     report.indexData
  //         .add(IndexModel(name: index, value: timeInEachIndex[index] / total));

  //     if (cip > 1 / total) {
  //       report.activityTexts.add("Spending too less time in $index");
  //       report.suggestions.add(SuggestionModel(
  //           text: "Some suggestion to spend more time in $index",
  //           imageUrl: placeHolderUrl,
  //           knowMoreUrl: placeHolderUrl));
  //     } else if (cip < -1 / total) {
  //       report.activityTexts.add("Spending too Much time in $index");
  //       report.suggestions.add(SuggestionModel(
  //           text: "Some suggestion to spend less time in $index",
  //           imageUrl: placeHolderUrl,
  //           knowMoreUrl: placeHolderUrl));
  //     }
  //   }

  //   report.indexData
  //       .sort((IndexModel a, IndexModel b) => a.value > b.value ? 0 : 1);
  //   // print("........................................");
  //   print(report.indexData);
  //   return report;
  // }

  getRawDatabase(String rollno) async {
    DocumentReference user = db.collection("users").doc(rollno);
    if (await user.get() == null) return null;
    var listofitems = (await user.collection("locationHistory").get()).docs;

    List<Map<String, Object>> res = [];
    //print("...................." + listofitems[2].data().toString());
    listofitems.forEach((element) {
      Map<String, dynamic> data = element.data();
      data["startTime"] = data["startTime"].toDate();
      data["endTime"] = data["endTime"].toDate();

      res.add(data);
    });
    return res;
  }
}

final kIndexNames = [
  "Administrative",
  "Hostels",
  "Electronics Inner Part",
  "Chemical Departmentt Innerpart",
  "Civil Department Inner Parts",
  "Concrete Geology inner parts",
  "Electrical Department inner parts",
  "Electronics Inner Part",
  "Main Workshop Inner Parts",
  "Sports and Grounds Inner Parts",
  "Out of Campus",
  "Other"
];
