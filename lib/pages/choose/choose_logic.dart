import 'package:freq_spark/db/db.dart';
import 'package:freq_spark/db/entity.dart';
import 'package:get/get.dart';

class ChooseController extends GetxController {
  final DB db = Get.find<DB>();
  Rx<List<Plan>> plans = Rx<List<Plan>>([]);

  clickPlan(int rate) {
    Get.back(result: rate);
  }

  @override
  void onInit() async {
    super.onInit();

    plans.value = await db.getAllPlans();
  }
}
