import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sana_starter/constants/network_constants.dart';
import 'package:sana_starter/constants/options_enum.dart';

class DynamicController extends GetxController {
  RxBool isActive = false.obs;

  Rx<Options> option = Options.timer.obs;

  RxBool startLoading = false.obs;

  GetStorage config = GetStorage("config_info");

  GetStorage user = GetStorage("user_info");

  setOptions(val) async {
    option.value = val;
    switch (val) {
      case Options.timer:
        break;
      case Options.configuration:
        break;
      case Options.call:
        await callNumber();
        break;
      case Options.hangup:
        break;
    }
  }

  showSnackBar(Icon icon, String title, String message) {
    Get.snackbar(title, message, icon: icon);
  }

  onTapConnect(val) async {
    startLoading.value = true;

    String errorMsg = "";

    try {
      await http
          .post(Uri.parse(val == true ? onUrl : offUrl))
          .timeout(const Duration(seconds: 15))
          .catchError((err) {}, test: (error) => error is int && error >= 400);

      isActive.value = val;
    } on SocketException catch (error) {
      errorMsg = error.osError.toString();
    } on TimeoutException catch (error) {
      errorMsg = error.message.toString();
    } on Exception catch (error) {
      errorMsg = error.toString();
    }

    startLoading.value = false;

    if (errorMsg.isNotEmpty) {
      showSnackBar(const Icon(Icons.power_settings_new), "Status",
          "Action failed. $errorMsg");
    }
  }

  onTapClose() async {
    startLoading.value = true;

    String errorMsg = "";

    try {
      await http
          .post(Uri.parse(closeUrl))
          .timeout(const Duration(seconds: 15))
          .catchError((err) {}, test: (error) => error is int && error >= 400);
    } on SocketException catch (error) {
      errorMsg = error.osError.toString();
    } on TimeoutException catch (error) {
      errorMsg = error.message.toString();
    } on Exception catch (error) {
      errorMsg = error.toString();
    }
    startLoading.value = false;

    if (errorMsg.isNotEmpty) {
      showSnackBar(const Icon(Icons.power_settings_new), "Status",
          "Action failed. $errorMsg");
    }
  }

  callNumber() async {
    config.write("mobile_num", "7993596198");

    if (config.hasData("mobile_num")) {
      bool? res =
          await FlutterPhoneDirectCaller.callNumber(config.read("mobile_num"));

      print(res!);


    } else {
      showSnackBar(const Icon(Icons.call), "Call Status",
          "Action failed. \nPlease register your starter details at configuration window.");
    }
  }
}
