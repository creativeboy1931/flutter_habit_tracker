import 'package:flutter/material.dart';
import 'package:flutter_habit_tracker/bindings/app_binding.dart';
import 'package:flutter_habit_tracker/controller/theme_controller.dart';
import 'package:flutter_habit_tracker/core/constants/string_constant.dart';
import 'package:flutter_habit_tracker/core/theme/theme.dart';
import 'package:flutter_habit_tracker/routes/app_routes.dart';
import 'package:get/get.dart';

void main() {
  final ThemeController themeController = Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController themeController = Get.find();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstant.appTitle,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      themeMode: themeController.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: AppRoutes.splash,
      initialBinding: AppBinding(),
      getPages: AppRoutes.page,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(1.0)),
          child: widget!,
        );
      },
    );
  }
}
