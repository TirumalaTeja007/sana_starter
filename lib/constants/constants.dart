import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:sana_starter/model/device_model.dart';

class Constants {
  List<DeviceModel> devices = [
    DeviceModel(
        name: 'SaNa Starter',
        isActive: false,
        color: "#7739ff",
        icon: 'assets/svg/starter.svg'),
  ];

  var activeColor = Rainbow(spectrum: [
    const Color(0xFF33C0BA),
    const Color(0xFF1086D4),
    const Color(0xFF6D04E2),
    const Color(0xFFC421A0),
    const Color(0xFFE4262F)
  ], rangeStart: 0.0, rangeEnd: 1.0);

  Color kWhite = const Color(0xFFFFFFFF);
}