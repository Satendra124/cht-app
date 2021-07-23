import 'package:flutter/material.dart';

import '../models/user.dart';

class Constants {
  static bool IS_TRACKING = false;
  static const dynamic ISOLATE_NAME = 'LocatorIsolate';
  static UserData currentUser;
  static bool TEST_MODE = true;
}

class SuggestionModel {
  String text;
  String imageUrl;
  String knowMoreUrl;
  SuggestionModel(
      {@required this.text,
      @required this.imageUrl,
      @required this.knowMoreUrl});
}
