import 'package:flutter_habit_tracker/features/home/screens/flash_screen.dart';
import 'package:flutter_habit_tracker/features/home/screens/home_screen.dart';
import 'package:get/get.dart';

abstract class AppRoutes {
  static const String splash = "/";
  static const String home = "/home";

  static final List<GetPage> page = [
    GetPage(name: splash, page: () => FlashScreen()),
    GetPage(name: home, page: () => HomeScreen()),
  ];
}
