import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana_starter/constants/enums.dart';
import 'package:sana_starter/controller/dynamic_controller.dart';
import 'package:sana_starter/widgets/transparent_card.dart';

class TempWidget1 extends StatelessWidget {
  final DynamicController controller;

  const TempWidget1({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Network Status",
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                    controller.networkStatus.value == NetworkStatus.online
                        ? "Online"
                        : "Offline",
                    style: TextStyle(
                        color: controller.networkStatus.value ==
                                NetworkStatus.online
                            ? Colors.white.withOpacity(0.4)
                            : Colors.black.withOpacity(0.3))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
