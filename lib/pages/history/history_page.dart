import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana_starter/constants/constants.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: Constants().kWhite,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              backgroundColor: Constants().kDarkBlue,
              elevation: 2,
              iconTheme: IconThemeData(color: Constants().kWhite),
              title: Text("Statistics",
                  style: TextStyle(
                      color: Constants().kWhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 20))),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05, vertical: 15),
            child: const Text(""),
          )),
    );
  }
}
