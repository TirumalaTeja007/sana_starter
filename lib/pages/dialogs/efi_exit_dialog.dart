import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana_starter/constants/constants.dart';

callExitDialog() {
  Get.defaultDialog(
    buttonColor: Colors.black.withOpacity(0.4),
    title: "Confirm Exit...!!",
    titleStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
    content: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Text("Are you sure you want to exit the app?",
            style: TextStyle(fontSize: 14))),
    contentPadding: const EdgeInsets.all(10),
    textCancel: "No",
    confirmTextColor: Colors.white,
    cancelTextColor: Colors.black.withOpacity(0.4),
    textConfirm: "Yes",
    onCancel: () => Get.back(),
    onConfirm: () => exit(0),
  );
}
