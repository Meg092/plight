import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'freq_home_logic.dart';

class FreqHomeView extends GetView<FreqHomeLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.stamm.value
              ? const CircularProgressIndicator(color: Colors.green)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.dqvlzmu();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
