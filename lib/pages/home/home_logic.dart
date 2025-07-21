import 'package:flutter/material.dart';
import 'package:freq_spark/db/db.dart';
import 'package:freq_spark/db/entity.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:torch_light/torch_light.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final DB db = Get.find<DB>();
  RxInt rate = 1500.obs;
  RxInt weight = 0.obs;
  RxBool isStart = false.obs;
  Rx<Timer?> timer = Rx<Timer?>(null);

  handleFlash() async {
    final bol = await _isTorchAvailable();
    if (!bol) {
      Fluttertoast.showToast(msg: 'Flashlight does not work');
      return;
    }
    isStart.value = !isStart.value;
    if (isStart.value) {
      _startBlinking();
    } else {
      _stopBlinking();
    }
  }

  updateRate(text) {
    if (text == '') {
      text = '0';
    }
    rate.value = int.parse(text);
    _updateInterval();
  }

  selectRate(int delta) {
    if (weight.value == delta) {
      weight.value = 0;
      return;
    }
    weight.value = delta;
  }

  changeRate(bool subOrPlus) {
    if (subOrPlus) {
      rate.value += weight.value;
    } else {
      rate.value -= weight.value;
    }
    rate.refresh();
    _updateInterval();
  }

  void _updateInterval() {
    if (isStart.value && rate.value > 0) {
      _stopBlinking();
      _startBlinking();
    }
  }

  Future<bool> _isTorchAvailable() async {
    try {
      return await TorchLight.isTorchAvailable();
    } catch (e) {
      print('Checking for flashlight availability failed: $e');
      return false;
    }
  }

  Future<void> _disableTorch() async {
    try {
      await TorchLight.disableTorch();
    } catch (e) {
      print('Failed to turn off flashlight: $e');
    }
  }

  void _startBlinking() async {
    await _stopBlinking();

    final lightSeconds = 400;

    timer.value = Timer.periodic(
      Duration(milliseconds: (rate.value).toInt() + lightSeconds),
      (timer) {
        try {
          TorchLight.enableTorch();

          Timer(Duration(milliseconds: lightSeconds), () async {
            if (isStart.value) {
              await _disableTorch();
            }
          });
        } catch (e) {
          print('Failed to turn on the flashlight: $e');
          _stopBlinking();
        }
      },
    );
  }

  Future<void> _stopBlinking() async {
    timer.value?.cancel();
    timer.value = null;
    await _disableTorch();
  }

  save(BuildContext context) async {
    final TextEditingController textController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 0.h),
            width: 360.w,
            height: 190.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Save the solution',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xff292929),
                      fontWeight: FontWeight.bold,
                    ),
                  ).paddingOnly(top: 8.h),
                ),
                SizedBox(height: 24.h),
                TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Solution Name',
                    hintStyle: TextStyle(
                      color: Color(0xFFA7A7A7),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: BorderSide(
                        color: Color(0xFFDBDBDB),
                        width: 1,
                      ),
                    ),
                  ),
                ).paddingSymmetric(horizontal: 10.w),
                SizedBox(height: 18.h),
                Divider(height: 1.h),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ButtonStyle(
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: Color(0xff242424),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (textController.text == '') {
                              Fluttertoast.showToast(msg: 'No scheme name filled in');
                              return;
                            }
                            try {
                              await db.insertPlan(
                                Plan(
                                  name: textController.text,
                                  rate: rate.value,
                                  date: DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(DateTime.now()),
                                ),
                              );
                              Fluttertoast.showToast(msg: 'Saved successfully');
                            } catch (err) {
                              Fluttertoast.showToast(msg: 'Save failed');
                            }

                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                          ),
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: Color(0xff242424),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 6.h),
                        width: 1.w,
                        height: 34.h,
                        decoration: BoxDecoration(color: Color(0xffEFEFEF)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  navigateChoose() async {
    rate.value = await Get.toNamed('/freq_choose') as int;
    _updateInterval();
  }

  navigateSetting() {
    Get.toNamed('/freq_setting');
  }

  // @override
  // void onInit() async {
  //   super.onInit();
  //   await checkNetwork();
  // }

  @override
  void dispose() async {
    super.dispose();
    await _stopBlinking();
  }

  Future<void> checkNetwork() async {
    final hadNetwork = await InternetConnectionChecker.instance.hasConnection;
    if (!hadNetwork) {
      Get.toNamed('/freq_wrong');
    }
  }
}
