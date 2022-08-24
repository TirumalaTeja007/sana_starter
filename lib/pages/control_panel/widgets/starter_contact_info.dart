import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana_starter/constants/constants.dart';
import 'package:sana_starter/controller/dynamic_controller.dart';
import 'package:sana_starter/widgets/transparent_card.dart';

class StarterContactInfo extends StatelessWidget {
  final DynamicController controller;

  const StarterContactInfo({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TransparentCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Starter contact number",
                style: TextStyle(
                    fontSize: 16,
                    color: Constants().kDarkBlue,
                    fontWeight: FontWeight.w700)),
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
                            ? Constants().kDarkBlue
                            : Constants().kDarkBlue.withOpacity(0.3))),
              )
            ]),
            const SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}
