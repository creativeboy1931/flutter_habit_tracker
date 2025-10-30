import 'package:flutter/material.dart';
import 'package:flutter_habit_tracker/data/model/habit_model.dart';
import 'package:intl/intl.dart';

class WeeklyStreakRow extends StatelessWidget {
  final Habit habit;
  final Color filledColor;
  final Color emptyColor;
  final Color textColor;

  const WeeklyStreakRow({
    super.key,
    required this.habit,
    this.filledColor = Colors.orange,
    this.emptyColor = const Color(0xFFE0E0E0),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday
    final formatter = DateFormat('d'); // Day number only

    // Create 7 days (Mon → Sun)
    final weekDays = List.generate(7, (i) {
      final day = startOfWeek.add(Duration(days: i));
      final dateStr = _dateToStr(day);
      final isCompleted = habit.completedDates.contains(dateStr);
      final isToday =
          day.year == now.year && day.month == now.month && day.day == now.day;

      return _buildDayCircle(
        dayNumber: formatter.format(day),
        isCompleted: isCompleted,
        isToday: isToday,
        filledColor: filledColor,
        emptyColor: emptyColor,
      );
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: weekDays,
      ),
    );
  }

  Widget _buildDayCircle({
    required String dayNumber,
    required bool isCompleted,
    required bool isToday,
    required Color filledColor,
    required Color emptyColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: isCompleted ? filledColor : emptyColor,
        shape: BoxShape.circle,
        border: isToday ? Border.all(color: Colors.blueAccent, width: 2) : null,
        boxShadow: isCompleted
            ? [
                BoxShadow(
                  color: filledColor.withOpacity(0.4),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      alignment: Alignment.center,
      child: Text(
        dayNumber,
        style: TextStyle(
          color: isCompleted ? Colors.white : Colors.black87,
          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  String _dateToStr(DateTime date) => '${date.year}-${date.month}-${date.day}';
}
