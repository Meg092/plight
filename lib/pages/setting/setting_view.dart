import 'package:flutter/material.dart';
import 'package:freq_spark/main.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

import './setting_logic.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(title: Text('Setting')),
      body: Column(
        children: [
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: _settingItem(
              'Clean All Records',
              onTap: () => controller.clearAllRecords(context),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                _settingItem('About us'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingItem(String title, {VoidCallback? onTap}) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, color: Color(0xFF242424)),
          ),
          Spacer(),
          title == 'About us' ? const Text("1.0.0") : const SizedBox()
        ],
      ).paddingOnly(left: 6.w),
    ).gestures(onTap: onTap);
  }
}
