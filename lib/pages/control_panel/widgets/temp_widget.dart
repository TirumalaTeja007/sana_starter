import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana_starter/controller/dynamic_controller.dart';
import 'package:sana_starter/widgets/transparent_card.dart';

class TempWidget extends StatelessWidget {
  final DynamicController controller;

  const TempWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TransparentCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Starter contact info",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Obx(
                () => Text(
                    controller.starterMobileNumber.value.isNotEmpty &&
                            controller.config.hasData("mobile_num")
                        ? controller.config.read("mobile_num")
                        : "Starter details are not configured ... ",
                    style: TextStyle(
                        color: controller.config.hasData("mobile_num")
                            ? Colors.white.withOpacity(0.4)
                            : Colors.black.withOpacity(0.3))),
              )
            ]),
            const SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}
