import 'package:flutter/material.dart';
import 'package:flutter_habit_tracker/core/constants/string_constant.dart';
import 'package:flutter_habit_tracker/core/theme/theme.dart';
import 'package:flutter_habit_tracker/routes/app_routes.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstant.appTitle,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.splash,
      initialBinding: null,
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
