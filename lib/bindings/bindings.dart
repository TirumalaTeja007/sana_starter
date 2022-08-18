import 'package:get/get.dart';
import 'package:sana_starter/controller/dynamic_controller.dart';

class DynamicBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DynamicController(), fenix: true);
  }
}