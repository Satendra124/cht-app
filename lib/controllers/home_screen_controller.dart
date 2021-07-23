import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final Rx<MenuState> menuState = MenuState.Close.obs;
  @override
  void onInit() async {
    super.onInit();
  }

  void openCloseMenu() {
    if (this.menuState.value == MenuState.Close)
      this.menuState.value = MenuState.Open;
    else
      this.menuState.value = MenuState.Close;
  }
}

enum MenuState { Close, Open }
