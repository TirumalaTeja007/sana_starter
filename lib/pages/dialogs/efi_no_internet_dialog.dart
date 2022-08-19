import 'package:flutter/material.dart';
import 'package:get/get.dart';

callNoInternetDialog(type) {
  Get.defaultDialog(
    barrierDismissible: true,
    titlePadding: const EdgeInsets.only(top: 10),
    title: "No Internet",
    titleStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
    content: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("...Could not initiate the requested action.",
              style: TextStyle(fontSize: 14, color: Colors.black45)),
        ],
      ),
    ),
  );
}
