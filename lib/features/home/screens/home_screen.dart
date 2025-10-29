import 'package:flutter/material.dart';
import 'package:flutter_habit_tracker/core/constants/string_constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(StringConstant.appTitle)),
      body: Center(child: Text("home page")),
      floatingActionButton: FloatingActionButton(onPressed: null),
    );
  }
}
