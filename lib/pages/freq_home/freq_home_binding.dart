import 'package:get/get.dart';

import 'freq_home_logic.dart';

class FreqHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      FreqHomeLogic(),
      permanent: true,
    );
  }
}
