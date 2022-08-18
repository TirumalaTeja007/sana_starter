import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana_starter/constants/constants.dart';
import 'package:sana_starter/constants/options_enum.dart';
import 'package:sana_starter/controller/dynamic_controller.dart';
import 'package:sana_starter/pages/control_panel/widgets/option_widget.dart';
import 'package:sana_starter/pages/control_panel/widgets/power_widget.dart';
import 'package:sana_starter/pages/control_panel/widgets/slider/slider_widget.dart';
import 'package:sana_starter/pages/control_panel/widgets/speed_widget.dart';
import 'package:sana_starter/pages/control_panel/widgets/temp_widget.dart';
import 'package:sana_starter/utils/slider_utils.dart';

import '../dialogs/efi_exit_dialog.dart';

class ControlPanelPage extends GetView<DynamicController> {
  const ControlPanelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => callExitDialog(),
        child: Scaffold(body: DynamicView(controller)));
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

  int speed = 1;

  double progressVal = 0.49;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.white,
              Constants().activeColor[1.0].withOpacity(0.5),
              Constants().activeColor[1.0]
            ]),
      ),
      child: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            baseColor: const Color(0xFFFFFFFF),
            opacityChangeRate: 0.25,
            minOpacity: 0.1,
            maxOpacity: 0.3,
            spawnMinSpeed: speed * 40.0,
            spawnMaxSpeed: speed * 80,
            spawnMinRadius: 2.0,
            spawnMaxRadius: 5.0,
            particleCount: widget.controller.isActive.value ? speed * 150 : 0,
          ),
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
                  children: const [
                    Text(
                      "Hi,Teja",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                        minRadius: 16,
                        backgroundImage: AssetImage("assets/images/user.webp"))
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      options(),
                      slider(),
                      controls(),
                    ],
                  ),
                )
              ],
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
        Obx(
          () => OptionWidget(
            icon: 'assets/svg/clock.svg',
            isSelected: widget.controller.option.value == Options.timer,
            onTap: () => widget.controller.setOptions(Options.timer),
            size: 32,
          ),
        ),
        Obx(
          () => OptionWidget(
            icon: 'assets/svg/config.svg',
            isSelected: widget.controller.option.value == Options.configuration,
            onTap: () => widget.controller.setOptions(Options.configuration),
            size: 25,
          ),
        ),
        Obx(
          () => OptionWidget(
            icon: 'assets/svg/call.svg',
            isSelected: widget.controller.option.value == Options.call,
            onTap: () => widget.controller.setOptions(Options.call),
            size: 28,
          ),
        ),
        Obx(
          () => OptionWidget(
            icon: 'assets/svg/hangup.svg',
            isSelected: widget.controller.option.value == Options.hangup,
            onTap: () => widget.controller.setOptions(Options.hangup),
            size: 30,
          ),
        ),
      ],
    );
  }

  Widget slider() {
    return SliderWidget(
      progressVal: progressVal,
      color: Constants().activeColor[1.0],
      onChange: (value) {
        setState(() {
          progressVal = normalize(value, kMinDegree, kMaxDegree);
        });
      },
    );
  }

  Widget controls() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SpeedWidget(
                speed: speed,
                changeSpeed: (val) => setState(() {
                      speed = val;
                    })),
            const SizedBox(width: 15),
            Expanded(
              child: PowerWidget(controller: widget.controller),
            ),
          ],
        ),
        const SizedBox(height: 15),
        TempWidget(controller: widget.controller),
        const SizedBox(height: 15),
      ],
    );
  }
}
