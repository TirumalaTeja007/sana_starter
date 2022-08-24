import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana_starter/constants/constants.dart';
import 'package:sana_starter/constants/enums.dart';
import 'package:sana_starter/controller/dynamic_controller.dart';
import 'package:sana_starter/pages/control_panel/widgets/option_widget.dart';
import 'package:sana_starter/pages/control_panel/widgets/power_widget.dart';
import 'package:sana_starter/pages/control_panel/widgets/slider/slider_widget.dart';
import 'package:sana_starter/pages/control_panel/widgets/starter_contact_info.dart';
import 'package:sana_starter/pages/control_panel/widgets/starter_status.dart';
import 'package:sana_starter/pages/user_info/user_info.dart';
import 'package:sana_starter/utils/slider_utils.dart';

import '../dialogs/efi_exit_dialog.dart';

class ControlPanelPage extends GetView<DynamicController> {
  const ControlPanelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => callExitDialog(),
      child: Scaffold(
        backgroundColor: Constants().kWhite,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            DynamicView(controller),
            Obx(
              () => controller.openUserDialog.value == true &&
                      !controller.user.hasData("user_name")
                  ? UserInfoPage(controller)
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicView extends StatefulWidget {
  const DynamicView(this.controller, {Key? key}) : super(key: key);
  final DynamicController controller;

  @override
  State<DynamicView> createState() => _DynamicViewState();
}

class _DynamicViewState extends State<DynamicView>
    with TickerProviderStateMixin {
  double progressVal = 0.49;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Obx(
        () => AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
                baseColor: const Color(0xFFFFFFFF),
                opacityChangeRate: 0.25,
                minOpacity: 0.1,
                maxOpacity: 0.3,
                spawnMinSpeed: 40.0,
                spawnMaxSpeed: 80,
                spawnMinRadius: 2.0,
                spawnMaxRadius: 5.0,
                particleCount: widget.controller.isActive.value ? 150 : 0),
          ),
          vsync: this,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: Get.width * 0.7,
                          child: Text(
                              "Hi, ${widget.controller.user.hasData("user_name") ? widget.controller.user.read("user_name") : "User"}",
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      const CircleAvatar(
                          minRadius: 16,
                          backgroundImage:
                              AssetImage("assets/images/user.webp"))
                    ],
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        slider(),
                        controls(),
                        options(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget options() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OptionWidget(
            icon: 'assets/svg/clock.svg',
            isSelected: widget.controller.option.value == Options.timer,
            onTap: () => widget.controller.setOptions(Options.timer),
            size: 32),
        OptionWidget(
            icon: 'assets/svg/config.svg',
            isSelected: widget.controller.option.value == Options.configuration,
            onTap: () {
              widget.controller.option.value = Options.configuration;
              Get.toNamed("/Settings",
                  arguments: {"controller": widget.controller});
            },
            size: 25),
        OptionWidget(
            icon: 'assets/svg/call.svg',
            isSelected: widget.controller.option.value == Options.call,
            onTap: () => widget.controller.setOptions(Options.call),
            size: 28),
        OptionWidget(
            icon: 'assets/svg/history.svg',
            isSelected: widget.controller.option.value == Options.history,
            onTap: () {
              widget.controller.setOptions(Options.history);
              Get.toNamed("/History",
                  arguments: {"controller": widget.controller});
            },
            size: 30),
      ],
    );
  }

  Widget slider() {
    return SliderWidget(
      progressVal: progressVal,
      color: Constants().kOrange,
      onChange: (value) {
        setState(() {
          progressVal = normalize(value, kMinDegree, kMaxDegree);
        });
      },
    );
  }

  Widget controls() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(child: StarterStatus(controller: widget.controller)),
        const SizedBox(width: 15),
        Expanded(child: PowerWidget(controller: widget.controller)),
      ]),
      const SizedBox(height: 15),
      StarterContactInfo(controller: widget.controller),
    ]);
  }
}
