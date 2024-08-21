import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void changeScreen(int index) {
    selectedIndex.value = index;
  }

  void reset() {
    selectedIndex.value = 0;
  }
}
