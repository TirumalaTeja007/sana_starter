import 'package:get/get.dart';
import 'package:sana_starter/bindings/bindings.dart';
import 'package:sana_starter/pages/control_panel/control_panel_page.dart';
import 'package:sana_starter/pages/introduction/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.introduction;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const ControlPanelPage(),
      binding: DynamicBindings(),
    ),
    GetPage(
      name: _Paths.introduction,
      page: () => const SplashView()
    ),
  ];
}
