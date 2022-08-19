import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sana_starter/constants/enums.dart';
import 'package:sana_starter/constants/network_constants.dart';
import 'package:sana_starter/helpers/error_responses.dart';
import 'package:sana_starter/pages/dialogs/efi_error_dialog.dart';

class DynamicController extends GetxController {
  RxBool isActive = false.obs;

  Rx<Options> option = Options.timer.obs;

  RxString starterMobileNumber = "XXX".obs;

  RxBool startLoading = false.obs;

  GetStorage config = GetStorage("config_info");

  GetStorage user = GetStorage("user_info");

  var networkStatus = NetworkStatus.unknown.obs;

  RxBool openUserDialog = true.obs;

  DynamicController() {
    networkService();
  }

  @override
  onInit() {
    starterMobileNumber.value = config.read("mobile_num") ?? "XXX";
    super.onInit();
  }

  networkService() {
    Connectivity()
        .checkConnectivity()
        .then((value) => networkStatus.value = _getNetworkStatus(value));

    Connectivity().onConnectivityChanged.listen((status) {
      networkStatus.value = _getNetworkStatus(status);
    });
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }

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
      case Options.history:
        break;
    }
  }

  onTapConnect(val) async {
    startLoading.value = true;

    String url = val == true ? onUrl : offUrl;

    try {
      final response = await http
          .post(Uri.parse(url))
          .timeout(const Duration(seconds: 15))
          .catchError((err) {}, test: (error) => error is int && error >= 400);

      if (response.statusCode == 200) {
        isActive.value = val;
      } else {
        httpErrorResponses(response);
      }
    } on SocketException catch (error) {
      socketException(error);
    } on TimeoutException catch (error) {
      timeoutException(error);
    } on Exception catch (error) {
      exception(error);
    }

    startLoading.value = false;
  }

  callNumber() async {
    config.write("mobile_num", "7993596198");

    if (config.hasData("mobile_num")) {
      bool? res =
          await FlutterPhoneDirectCaller.callNumber(config.read("mobile_num"));

      print(res!);

    } else {
      callErrorDialog("Call Status",
          "Action failed. \nPlease register your starter details at configuration window.");
    }
  }
}
