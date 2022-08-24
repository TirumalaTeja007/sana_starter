import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana_starter/controller/dynamic_controller.dart';
import 'package:sana_starter/widgets/transparent_card.dart';

import '../../../constants/constants.dart';

class PowerWidget extends StatelessWidget {
  final DynamicController controller;

  const PowerWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentCard(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Power",
                    style: TextStyle(
                        fontSize: 16,
                        color: Constants().kDarkBlue,
                        fontWeight: FontWeight.w700)),
                controller.startLoading.value == true
                    ? const CupertinoActivityIndicator()
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('Off',
                        style: TextStyle(
                            color: !controller.isActive.value
                                ? Constants().kDarkBlue
                                : Constants().kDarkBlue.withOpacity(0.3))),
                    Text('/',
                        style: TextStyle(
                            color: Constants().kDarkBlue.withOpacity(0.3))),
                    Text('On',
                        style: TextStyle(
                            color: controller.isActive.value
                                ? Constants().kDarkBlue
                                : Constants().kDarkBlue.withOpacity(0.3))),
                  ],
                ),
                Transform.scale(
                  alignment: Alignment.center,
                  scaleY: 0.8,
                  scaleX: 0.85,
                  child: CupertinoSwitch(
                    onChanged: (val) => controller.onTapConnect(val),
                    value: controller.isActive.value,
                    activeColor: Constants().kDarkBlue,
                    trackColor: Colors.black.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
