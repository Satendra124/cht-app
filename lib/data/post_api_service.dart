import 'dart:convert';

import 'package:cht/controllers/report_data_controller.dart';
import 'package:cht/models/report_model.dart';
import 'package:cht/models/user.dart';
import 'package:cht/util/AppConstants.dart';
import 'package:cht/util/constants.dart';
import 'package:http/http.dart';

class PostApiService {
  static const String BASE_URL = AppConstants.BASE_URL;

  Future<UserData> loginPost(String idToken) async {
    Uri uri = Uri.parse(BASE_URL + "login/");
    Response response = await post(uri, body: {"id_token": idToken});
    print(response.body);
    Map<String, dynamic> res = jsonDecode(response.body);
    UserData user = UserData.fromJson(res);
    return user;
  }

  Future<UserData> userGet(String uid) async {
    Uri uri = Uri.parse(BASE_URL + "user/");
    Response response = await post(uri, body: {"useruid": uid});
    print(response.body);
    Map<String, dynamic> res = jsonDecode(response.body);
    UserData user = UserData.fromJson(res);
    return user;
  }

  Future<Report> getReport(ReportDateRangeType type) async {
    String typeStr = "";
    if (type == ReportDateRangeType.today)
      typeStr = "1";
    else if (type == ReportDateRangeType.last7days)
      typeStr = "7";
    else
      typeStr = "30";
    String useruid = Constants.currentUser.uid;
    Uri uri = Uri.parse(BASE_URL + "user/");
    Response response =
        await post(uri, body: {"useruid": useruid, "Typeofdata": typeStr});
    Report report = parseFromServer(response.body);
    return report;
  }

  Report parseFromServer(String response) {
    Map<String, dynamic> res = jsonDecode(response);
    print("............" + response);
  }
}
