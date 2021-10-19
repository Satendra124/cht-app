import 'package:cht/controllers/app_controller.dart';
import 'package:cht/screens/fetch.dart';
import 'package:cht/services/AuthService.dart';
import 'package:cht/services/channels.dart';
import 'package:cht/util/AppConstants.dart';
import 'package:cht/util/colorConstants.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthScreen extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final messages = <Widget>[];
  final AppStateController appContoller = Get.find<AppStateController>();
  @override
  Widget build(BuildContext context) {
    appContoller.authState.listen((val) {
      if (appContoller.authState.value == AuthState.LoggedIn &&
          appContoller.permissionState.value == PermissionState.Granted) {
        Get.off(() => FetchPage());
      }
    });
    appContoller.permissionState.listen((val) {
      if (appContoller.authState.value == AuthState.LoggedIn &&
          appContoller.permissionState.value == PermissionState.Granted) {
        Get.off(() => FetchPage());
      }
    });
    return Scaffold(
      backgroundColor: ColorLight.themeColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 800,
            child: Column(
              children: [
                Spacer(),
                _title("Welcome!"),
                //Spacer(),
                SizedBox(height: 30),
                //_normalMessage("Sign in with your institute email id:"),
                //SizedBox(height: 30),
                Obx(() => appContoller.authState.value == AuthState.LoggedOut
                    ? _signInButton()
                    : Container()),
                Obx(() => appContoller.authState.value == AuthState.LoggedIn
                    ? _permission_button()
                    : Container()),
                Obx(() => appContoller.authState.value == AuthState.Loading ||
                        appContoller.permissionState.value ==
                            PermissionState.Loading
                    ? _loading()
                    : Container()),
                Spacer(),
              ],
            ),
          ),
        ),
        //child: Obx(() => Text(messageController.m.value)),
      ),
    );
  }

  Widget _loading() {
    return Column(
      children: [
        CircularProgressIndicator(
          backgroundColor: ColorLight.white,
        ),
        _normalMessage("Loading..")
      ],
    );
  }

  Widget _normalMessage(String message) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: TextStyle(fontFamily: "OpenSans"),
          ),
        ),
      ),
    );
  }

  Widget _errorMessage(String message) {
    return Container();
  }

  Widget _userMessage(String message) {
    return Container();
  }

  Widget _action(String message) {
    return Container();
  }

  Widget _signInButton() {
    //return Container();
    return Container(
      width: screenWidth - 50,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(ColorLight.white)),
          onPressed: () async {
            AppConstants.curUser = await signInWithGoogle();
            GetStorage box = GetStorage();
            box.write("curUser", AppConstants.curUser.uid);
          },
          child: Row(
            children: [
              Container(
                width: 50,
                child: Image.asset("assets/google_logo.png"),
              ),
              Text(
                "Sign in with Google",
                style: TextStyle(color: ColorLight.themeColor),
              )
            ],
          )),
    );
  }

  Widget _permission_button() {
    return Container(
      width: screenWidth - 50,
      height: 50,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorLight.secondaryColor)),
          onPressed: () {
            askForPermissions();
          },
          child: Row(
            children: [
              Container(
                width: 50,
                child: Icon(
                  Icons.security,
                  color: ColorLight.white,
                  size: 30,
                ),
              ),
              Text(
                "Allow Permissions",
                style: TextStyle(color: ColorLight.themeColor),
              )
            ],
          )),
    );
  }

  Widget _title(String title) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: TextStyle(
                color: ColorLight.white,
                fontFamily: "LukiestGuy",
                fontSize: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
