import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter/services.dart';

import './home_logic.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController(
      text: controller.rate.value.toString(),
    );
    textController.selection = TextSelection.fromPosition(
      TextPosition(offset: textController.text.length),
    );
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        width: double.infinity,
        child: SingleChildScrollView(
          child: SafeArea(
            child: <Widget>[
                  SizedBox(height: 48.h),
                  Text('Flash frequency')
                      .fontSize(24.sp)
                      .textColor(Color(0xff0F0F0F))
                      .fontWeight(FontWeight.bold)
                      .alignment(Alignment.center),
                  SizedBox(height: 24.h),
                  Obx(
                    () => Image.asset(
                      controller.isStart.value
                          ? 'assets/light.webp'
                          : 'assets/dark.webp',
                      width: 83.w,
                      height: 83.h,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/sub.webp',
                            width: 35.w,
                            height: 35.h,
                          ).gestures(
                            onTap: () {
                              controller.changeRate(false);
                              textController.text =
                                  controller.rate.value.toString();
                              textController
                                  .selection = TextSelection.fromPosition(
                                TextPosition(
                                  offset: textController.text.length,
                                ),
                              );
                            },
                          ),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]'),
                                ),
                              ],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w800,
                              ),
                              controller: textController,
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: TextStyle(
                                  color: const Color.fromARGB(221, 87, 86, 86),
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                isCollapsed: true,
                              ),
                              onChanged: controller.updateRate,
                            ),
                          ),
                          Image.asset(
                            'assets/plus.webp',
                            width: 35.w,
                            height: 35.h,
                          ).gestures(
                            onTap: () {
                              controller.changeRate(true);
                              textController.text =
                                  controller.rate.value.toString();
                              textController
                                  .selection = TextSelection.fromPosition(
                                TextPosition(
                                  offset: textController.text.length,
                                ),
                              );
                            },
                          ),
                        ],
                      )
                      .padding(horizontal: 6.w)
                      .decorated(
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(color: Color(0xffDBDBDB)),
                      ),
                  SizedBox(height: 12.h),
                  Obx(
                    () => Wrap(
                      spacing: 9.w,
                      runSpacing: 9.h,
                      children: [
                        _quickButton(
                          '+5',
                          () => controller.selectRate(5),
                          isSelect: controller.weight.value == 5,
                        ),
                        _quickButton(
                          '+10',
                          () => controller.selectRate(10),
                          isSelect: controller.weight.value == 10,
                        ),
                        _quickButton(
                          '+50',
                          () => controller.selectRate(50),
                          isSelect: controller.weight.value == 50,
                        ),
                        _quickButton(
                          '+100',
                          () => controller.selectRate(100),
                          isSelect: controller.weight.value == 100,
                        ),
                        _quickButton(
                          '-5',
                          () => controller.selectRate(-5),
                          isSelect: controller.weight.value == -5,
                        ),
                        _quickButton(
                          '-10',
                          () => controller.selectRate(-10),
                          isSelect: controller.weight.value == -10,
                        ),
                        _quickButton(
                          '-50',
                          () => controller.selectRate(-50),
                          isSelect: controller.weight.value == -50,
                        ),
                        _quickButton(
                          '-100',
                          () => controller.selectRate(-100),
                          isSelect: controller.weight.value == -100,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => Text(controller.isStart.value ? 'End' : 'Start')
                        .fontSize(30.sp)
                        .fontWeight(FontWeight.w800)
                        .textColor(Colors.white)
                        .alignment(Alignment.center)
                        .backgroundColor(
                          controller.isStart.value
                              ? Color(0xffff9300)
                              : Color(0xFF38C24E),
                        )
                        .clipRRect(all: 100.r)
                        .height(92.h)
                        .gestures(onTap: controller.handleFlash)
                        .alignment(Alignment.center),
                  ),
                  SizedBox(height: 26.h),
                  _menuItem('Save the solution', () => controller.save(context)),
                  _menuItem('Choose a plan', controller.navigateChoose),
                  _menuItem('Program Settings', controller.navigateSetting),
                ]
                .toColumn(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                )
                .decorated(color: Colors.transparent)
                .gestures(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
          ),
        ),
      ),
    );
  }

  Widget _quickButton(
    String text,
    VoidCallback onTap, {
    bool isSelect = false,
  }) {
    return Text(text)
        .fontSize(18.sp)
        .fontWeight(FontWeight.w600)
        .alignment(Alignment.center)
        .backgroundColor(isSelect ? Color(0xFFCCCCCC) : Color(0xFFF2F2F2))
        .clipRRect(all: 8.r)
        .width(79.w)
        .height(38.h)
        .gestures(onTap: onTap);
  }

  Widget _menuItem(String title, VoidCallback onTap) {
    return <Widget>[
          Text(title)
              .fontSize(14.sp)
              .fontWeight(FontWeight.w600)
              .textColor(Color(0xff101010)),
          const Spacer(),
          Image.asset('assets/right.webp', width: 20.w, height: 20.h),
        ]
        .toRow()
        .height(45.h)
        .padding(horizontal: 16.w, vertical: 2.h)
        .decorated(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(10.r),
        )
        .padding(vertical: 6.h, horizontal: 8.w)
        .gestures(onTap: onTap);
  }
}
