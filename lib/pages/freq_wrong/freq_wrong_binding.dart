import 'package:get/get.dart';

import './freq_wrong_logic.dart';

class FreqWrongBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FreqWrongLogic());
  }
}
