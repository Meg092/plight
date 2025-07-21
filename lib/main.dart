import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freq_spark/pages/choose/choose_binding.dart';
import 'package:freq_spark/pages/choose/choose_view.dart';
import 'package:freq_spark/pages/freq_wrong/freq_wrong_binding.dart';
import 'package:freq_spark/pages/freq_wrong/freq_wrong_view.dart';
import 'package:freq_spark/pages/home/home_binding.dart';
import 'package:freq_spark/pages/home/home_view.dart';
import 'package:freq_spark/pages/setting/setting_binding.dart';
import 'package:freq_spark/pages/setting/setting_view.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './db/db.dart';

Color primaryColor = const Color(0xFFF5F5F5);
Color bgColor = const Color(0xFFFFFFFF);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Get.putAsync(() => DB().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 860), // 设计图尺寸
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: PLight,
          initialRoute: '/freq_tab',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: primaryColor,
            scaffoldBackgroundColor: bgColor,
            colorScheme: ColorScheme.light(primary: primaryColor),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF0F0F0F),
                backgroundColor: Colors.white,
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            cardTheme: const CardTheme(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            dialogTheme: const DialogTheme(
              actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
            ),
            dividerTheme: DividerThemeData(
              thickness: 1,
              color: Colors.grey[200],
            ),
          ),
        );
      },
    );
  }
}
List<GetPage<dynamic>> PLight = [
  GetPage(
    name: '/freq_tab',
    page: () => HomePage(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: '/freq_setting',
    page: () => SettingPage(),
    binding: SettingBinding(),
  ),
  GetPage(
    name: '/freq_wrong',
    page: () => FreqWrongView(),
    binding: FreqWrongBinding(),
  ),
  GetPage(
    name: '/freq_choose',
    page: () => ChoosePage(),
    binding: ChooseBinding(),
  ),
];