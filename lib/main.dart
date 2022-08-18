import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sana_starter/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage("user_info").initStorage;
  await GetStorage("config_info").initStorage;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SaNa Starter',
      theme: ThemeData(
        fontFamily: "Poppins",
        sliderTheme: const SliderThemeData(
          trackShape: RectangularSliderTrackShape(),
          trackHeight: 2.5,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 15.0),
        ),
      ),
      initialRoute: Routes.introduction,
      getPages: AppPages.routes,
    );
  }
}
