import 'dart:convert';

import 'package:cht/models/user.dart';
import 'package:cht/util/AppConstants.dart';
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
    Response response = await post(uri, body: {"uid": uid});
    print(response.body);
    Map<String, dynamic> res = jsonDecode(response.body);
    UserData user = UserData.fromJson(res);
    return user;
  }

  // Future<Report> getReport(String uid, DateTime dateDay) async {
  //   Uri uri = Uri.parse(BASE_URL + "algorithm/report/");
  //   Response response = await post(uri,
  //       body: {"useruid": uid, "dateDay": dateDay.toIso8601String()});
  //   print("----------------------------------" + response.body);
  //   Map<String, dynamic> res = jsonDecode(response.body);
  //   //print("----------------------------------" + res['suggestions'].toString());
  //   Report report = Report.fromJson(res);
  //   return report;
  // }
}
