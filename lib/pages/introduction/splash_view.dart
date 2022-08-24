import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sana_starter/constants/constants.dart';
import 'package:sana_starter/routes/app_pages.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  @override
  initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      timer.cancel();
      Get.offAndToNamed(Routes.home);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().kWhite,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // child: AnimatedBackground(
        //   behaviour: RandomParticleBehaviour(
        //     options: ParticleOptions(
        //       baseColor: Constants().kWhite,
        //       opacityChangeRate: 0.25,
        //       minOpacity: 0.1,
        //       maxOpacity: 0.3,
        //       spawnMinSpeed: 40.0,
        //       spawnMaxSpeed: 80,
        //       spawnMinRadius: 2.0,
        //       spawnMaxRadius: 5.0,
        //       particleCount: 150,
        //     ),
        //   ),
        //   vsync: this,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/starter.svg',
                  color: Constants().kOrange,
                  height: 30,
                ),
                const SizedBox(height: 10),
                  Text('SaNa Starter',
                      style: TextStyle(
                          color: Constants().kDarkBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 24))
                ],
              ),
            ),
          ),
        //),
      ),
    );
  }
}
