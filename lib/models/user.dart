import 'package:cht/models/index.dart';
import 'package:cht/util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final String name;
  final String branch;
  final String uid;
  final String photoUrl;
  final String djangoToken;
  final String yearOfJoining;
  final String email;
  UserData(
      {this.name,
      this.branch,
      this.uid,
      this.photoUrl,
      this.djangoToken,
      this.yearOfJoining,
      this.email});
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        name: json['name'],
        branch: json['branch'],
        djangoToken: json['token'],
        email: json['email'],
        photoUrl: json['photo_url'],
        uid: json['uid'],
        yearOfJoining: json['year_of_joining']);
  }
}

class LocationHistoryLite {
  String place;
  DateTime start;
  DateTime end;
  LocationHistoryLite({this.place, this.start}) {
    end = start;
  }
}
