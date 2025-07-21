import 'package:get/get.dart';

import 'choose_logic.dart';

class ChooseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChooseController());
  }
}
