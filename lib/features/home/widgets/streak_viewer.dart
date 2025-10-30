import 'package:flutter/material.dart';
import 'package:flutter_habit_tracker/core/constants/my_size.dart';
import 'package:flutter_habit_tracker/core/constants/string_constant.dart';
import 'package:flutter_habit_tracker/data/model/habit_model.dart';
import 'package:flutter_habit_tracker/features/home/widgets/weekly_steak_viewer.dart';

class StreakReportView extends StatefulWidget {
  final Habit habit;
  const StreakReportView({super.key, required this.habit});

  @override
  State<StreakReportView> createState() => _StreakReportViewState();
}

class _StreakReportViewState extends State<StreakReportView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  int streak = 0;

  @override
  void initState() {
    super.initState();
    streak = widget.habit.completedDates.length;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: streak.toDouble(),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habit = widget.habit;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            height: 6,
            width: 60,
            margin: const EdgeInsets.only(bottom: MySizes.paddingMarginMd),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
        Text(
          habit.name,
          style: theme
              .textTheme
              .headlineMedium, //const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: MySizes.titleSpace),
        Text(
          'Created on: ${habit.createdAt.toLocal().toString().split(' ')[0]}',
        ),

        const SizedBox(height: MySizes.spaceBtwItems),

        WeeklyStreakRow(habit: widget.habit), //week day of streak

        const SizedBox(height: MySizes.spaceBtwSections + 10),
        Text('🔥 Current Streak', style: theme.textTheme.headlineSmall),
        const SizedBox(height: MySizes.spaceBtwSections),
        Center(
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return Column(
                children: [
                  Text(
                    '${_progressAnimation.value.toInt()} days',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: MySizes.defaultSpace),
                  LinearProgressIndicator(
                    value: (_progressAnimation.value / 30).clamp(
                      0.0,
                      1.0,
                    ), // assuming 30-day goal
                    color: Colors.orange,
                    backgroundColor: Colors.grey.shade200,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ],
              );
            },
          ),
        ),
        // const SizedBox(height: MySizes.spaceBtwSections),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Opacity(
                  opacity: 0.89,
                  child: Image.asset(
                    'assets/images/fire.png',
                    height: MySizes.imageCarouselHeight,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: MySizes.titleSpace),
                Text(StringConstant.appTitle, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
