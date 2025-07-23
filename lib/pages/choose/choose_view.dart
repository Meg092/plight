import 'package:flutter/material.dart';
import 'package:freq_spark/main.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

import 'choose_logic.dart';

class ChoosePage extends GetView<ChooseController> {
  const ChoosePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(title: Text('Choose a plan')),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Obx(
            () =>
            controller.plans.value.isEmpty ? Align(child:<Widget>[
              const SizedBox(height: 80,),
              const Text("No plan yet, please add a plan"),
            ].toColumn()) : <Widget>[
                  ...controller.plans.value.map((plan) {
                    return _card(
                      name: plan.name,
                      date: plan.date,
                      rate: plan.rate,
                      onTap: () => controller.clickPlan(plan.rate),
                    );
                  }),
                ].toColumn(),
          ),
        ),
      ),
    );
  }

  Widget _card({
    required String name,
    String? date,
    required int rate,
    required VoidCallback onTap,
  }) {
    return <Widget>[
          <Widget>[
            Text(name)
                .fontSize(16.sp)
                .textColor(Color(0xff292929))
                .fontWeight(FontWeight.bold),
            Text(date ?? '')
                .fontSize(16.sp)
                .textColor(Color(0xffA7A7A7))
                .fontWeight(FontWeight.w400),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
          Text(rate.toString())
              .fontSize(40.sp)
              .textColor(Color(0xff292929))
              .fontWeight(FontWeight.bold),
        ]
        .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
        .padding(vertical: 16.h, horizontal: 24.w)
        .decorated(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.r),
        )
        .marginOnly(bottom: 12.h)
        .gestures(onTap: onTap);
  }
}
