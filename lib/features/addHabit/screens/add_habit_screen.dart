import 'package:flutter/material.dart';
import 'package:flutter_habit_tracker/controller/habit_list_controller.dart';
import 'package:flutter_habit_tracker/core/constants/my_size.dart';
import 'package:flutter_habit_tracker/core/constants/string_constant.dart';
import 'package:flutter_habit_tracker/core/helpers/validators.dart';
import 'package:flutter_habit_tracker/features/addHabit/widgets/add_asset_img.dart';
import 'package:get/get.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final habitListController = Get.find<HabitListController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Habit')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // 🔹 Attach the form key
            child: Column(
              children: [
                AddAssetImg(src: "assets/images/habit-min.png"),
                Text("Build a Habit", style: theme.textTheme.headlineMedium),
                SizedBox(height: MySizes.spaceBtwSections),
                TextFormField(
                  controller: _controller,
                  validator: (value) =>
                      Validators.validateEmptyText("Habit Name", value),
                  style: theme.textTheme.titleMedium,
                  spellCheckConfiguration: SpellCheckConfiguration.disabled(),
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: StringConstant.habitInputLable,
                    labelStyle: TextStyle(fontSize: MySizes.labelSizeLg),
                    hintText: StringConstant.habitInputHint,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        habitListController.addHabit(_controller.text);
                        Get.back();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
