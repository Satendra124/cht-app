import 'package:cht/controllers/app_controller.dart';
import 'package:cht/util/AppConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void startMainServices() async {
  //return;
  const MethodChannel _channel = const MethodChannel('service_channel');
  await _channel.invokeMethod('startLocationServer', {
    "useruid": AppConstants.curUser.uid ?? FirebaseAuth.instance.currentUser.uid
  }); //TODO
}

Future<bool> lookIfServiceCompleted(int calls) async {
  //return true;
  const MethodChannel _channel = const MethodChannel('service_channel');
  bool isServiceStart = await _channel.invokeMethod('checkIfServiceStart');
  if (isServiceStart)
    return true;
  else if (calls > 100)
    return false; //Timeout
  else {
    await Future.delayed(Duration(seconds: 1));
    return await lookIfServiceCompleted(calls + 1);
  }
}

Future<bool> isMainServiceRunning() async {
  const MethodChannel _channel = const MethodChannel('service_channel');
  bool isServiceStart = await _channel.invokeMethod('checkIfServiceStart');
  return isServiceStart;
}

void askForPermissions() {
  AppStateController appStateController = Get.find<AppStateController>();
  appStateController.permissionState.value = PermissionState.Loading;

  appStateController.permissionState.value = PermissionState.Granted;
}
