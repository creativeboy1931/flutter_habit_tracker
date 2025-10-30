import 'package:flutter/material.dart';
import 'package:flutter_habit_tracker/controller/habit_list_controller.dart';
import 'package:flutter_habit_tracker/controller/theme_controller.dart';
import 'package:flutter_habit_tracker/core/constants/my_size.dart';
import 'package:flutter_habit_tracker/core/constants/string_constant.dart';
import 'package:flutter_habit_tracker/core/constants/app_colors.dart';
import 'package:flutter_habit_tracker/data/model/habit_model.dart';
import 'package:flutter_habit_tracker/features/home/widgets/calendar_viewer.dart';
import 'package:flutter_habit_tracker/features/home/widgets/streak_viewer.dart';
import 'package:flutter_habit_tracker/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:flutter_confetti/flutter_confetti.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HabitListController habitController = Get.find<HabitListController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wSize = MediaQuery.of(context).size.width;
    final ThemeController themeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstant.appTitle),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.wb_sunny
                    : Icons.nights_stay,
              ),
              onPressed: () => themeController.toggleTheme(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(MySizes.paddingMarginSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //current callandar show
            const CalendarViewer(),
            Divider(
              endIndent: wSize * 0.37,
              indent: wSize * 0.37,
              thickness: 3,
            ),

            SizedBox(height: MySizes.defaultSpace),
            Text(
              "My Habits",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: MySizes.titleSpace),
            Obx(() {
              if (habitController.habits.isEmpty) {
                return const Center(
                  child: Text(
                    StringConstant.habitListEmpty,
                    style: TextStyle(color: AppColors.info),
                  ),
                );
              }

              return Expanded(
                child: ListView.separated(
                  itemCount: habitController.habits.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    final habit = habitController.habits[index];
                    final isDone = habit.isCompletedToday();
                    return ListTile(
                      title: Text(
                        habit.name,
                        style: theme.textTheme.titleLarge,
                      ),
                      subtitle: Container(
                        margin: const EdgeInsets.only(
                          top: MySizes.paddingMarginXs,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: isDone
                            ? BoxDecoration(
                                color: theme.colorScheme.surface.withAlpha(100),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color.fromARGB(
                                    36,
                                    215,
                                    227,
                                    235,
                                  ),
                                ),
                              )
                            : null,
                        child: Text(
                          'Streak: ${habit.getCurrentStreak()} days',
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          isDone ? Icons.check_circle : Icons.circle_outlined,
                          color: isDone ? Colors.green : Colors.grey,
                        ),
                        onPressed: () {
                          habitController.toggleHabitCompletion(habit);
                          if (!isDone) {
                            Confetti.launch(
                              context,
                              options: const ConfettiOptions(
                                particleCount: 100,
                                spread: 80,
                                y: 0.6,
                                gravity: 0.5,
                              ),
                            );
                          }
                        },
                      ),
                      onTap: () => _showStreakReport(context, habit),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 10),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () => Get.toNamed(AppRoutes.addHabit),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showStreakReport(BuildContext context, Habit habit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // so we can round corners
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8, // 80% of screen height
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.all(20),
            child: StreakReportView(habit: habit),
          ),
        );
      },
    );
  }
}
