import 'package:flutter/material.dart';
import 'package:get/get.dart';

callErrorDialog(String title, String message) {
  Get.defaultDialog(
    buttonColor: Colors.white,
    title: title,
    titleStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
    content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(message, style: const TextStyle(fontSize: 14))),
    contentPadding: const EdgeInsets.all(10),
    cancelTextColor: Colors.blue,
    textCancel: "Close",
    onCancel: () => Get.back(),
  );
}
