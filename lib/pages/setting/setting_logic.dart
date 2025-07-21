import 'package:flutter/material.dart';
import 'package:freq_spark/db/db.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingController extends GetxController {
  final DB db = Get.find<DB>();

  clearAllRecords(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 0.h),
            width: 300.w,
            height: 110.h,
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
                    'Delete？',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff242424),
                      fontWeight: FontWeight.bold,
                    ),
                  ).paddingOnly(top: 8.h),
                ),
                SizedBox(height: 16.h),
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
                            await db.clearRecords();
                            Fluttertoast.showToast(msg: 'Deleted successfully');
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

  @override
  void onInit() async {
    super.onInit();
  }
}
