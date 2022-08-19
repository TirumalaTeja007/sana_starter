import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana_starter/controller/dynamic_controller.dart';
import 'package:sana_starter/widgets/transparent_card.dart';

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
                const Text("Power",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
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
                RichText(
                  text: TextSpan(
                      text: 'OFF',
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: !controller.isActive.value
                              ? Colors.white
                              : Colors.black.withOpacity(0.3),
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                            text: '/',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3))),
                        TextSpan(
                          text: 'ON',
                          style: TextStyle(
                            color: controller.isActive.value
                                ? Colors.white
                                : Colors.black.withOpacity(0.3),
                          ),
                        ),
                      ]),
                ),
                Transform.scale(
                  alignment: Alignment.center,
                  scaleY: 0.8,
                  scaleX: 0.85,
                  child: CupertinoSwitch(
                    onChanged: (val) => controller.onTapConnect(val),
                    value: controller.isActive.value,
                    activeColor: Colors.white.withOpacity(0.5),
                    trackColor: Colors.black.withOpacity(0.2),
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
