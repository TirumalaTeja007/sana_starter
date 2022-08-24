import 'package:flutter/material.dart';
import 'package:sana_starter/constants/constants.dart';
import 'package:sana_starter/controller/dynamic_controller.dart';
import 'package:sana_starter/widgets/transparent_card.dart';

class StarterStatus extends StatelessWidget {
  final DynamicController controller;

  const StarterStatus({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Starter Status",
            style: TextStyle(
                fontSize: 16,
                color: Constants().kDarkBlue,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Inactive", style: TextStyle(color: Constants().kDarkBlue)),
            ],
          ),
        ],
      ),
    );
  }
}
