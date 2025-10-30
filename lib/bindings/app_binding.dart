import 'package:flutter_habit_tracker/controller/habit_list_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ThemeController>(() => ThemeController(), fenix: true);
    Get.lazyPut<HabitListController>(() => HabitListController(), fenix: true);
  }
}
