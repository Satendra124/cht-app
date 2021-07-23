import 'package:cht/controllers/app_controller.dart';
import 'package:cht/screens/auth.dart';
import 'package:cht/screens/homepage/home.dart';
import 'package:cht/services/channels.dart';
import 'package:cht/util/colorConstants.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FetchPage extends StatefulWidget {
  @override
  _FetchPageState createState() => _FetchPageState();
}

class _FetchPageState extends State<FetchPage> {
  final AppStateController appStateController = Get.put(AppStateController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () => init());
    });
    super.initState();
  }

  init() {
    if (appStateController.authState.value == AuthState.LoggedIn &&
        appStateController.serviceState.value == ServiceState.On) {
      Get.off(() => HomePage());
    }
    if (appStateController.authState.value == AuthState.LoggedIn) {
      if (appStateController.serviceState.value == ServiceState.On)
        Get.off(() => HomePage());
      else {
        startMainServices();
        lookIfServiceCompleted(0).then((value) {
          if (value)
            Get.off(() => HomePage());
          else {
            print("ERROR IN STARTING SERVICE");
            Get.snackbar("Error", "Timeout");
          }
        });
      }
    } else {
      Get.off(() => AuthScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Center(child: Image.asset("assets/appLogo.png")),
          Positioned(
              bottom: 10,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: ColorLight.white,
                  )))),
        ],
      ),
    );
  }
}
