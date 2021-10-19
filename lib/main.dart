import 'package:cht/models/quiz.dart';
import 'package:cht/screens/auth/quiz.dart';
import 'package:cht/screens/fetch.dart';
import 'package:cht/util/constants.dart';
import 'package:cht/util/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  print("..........." + (await messaging.getToken()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.basicTheme,
      home: FetchPage(),
    );
  }
}
