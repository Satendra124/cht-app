import 'package:cht/services/channels.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cht/services/AuthService.dart';

class AppStateController extends GetxController {
  final Rx<AuthState> authState = AuthState.LoggedOut.obs;
  final Rx<PermissionState> permissionState = PermissionState.NotGranted.obs;
  final Rx<ServiceState> serviceState = ServiceState.Off.obs;
  @override
  void onInit() async {
    super.onInit();
    authState.value = await _getAuthState();
    permissionState.value = _getPermissionState();
    serviceState.value = await _getServiceState();
  }

  Future<AuthState> _getAuthState() async {
    if (FirebaseAuth.instance.currentUser == null)
      return AuthState.LoggedOut;
    else {
      await loadUser();
      return AuthState.LoggedIn;
    }
  }

  PermissionState _getPermissionState() {
    return PermissionState.NotGranted;
  }

  Future<ServiceState> _getServiceState() async {
    if (await isMainServiceRunning())
      return ServiceState.On;
    else
      return ServiceState.Off;
  }
}

enum AuthState { Loading, LoggedIn, LoggedOut }

enum PermissionState { Loading, Granted, NotGranted }

enum ServiceState { Off, On, Loading }
