import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_habit_tracker/data/model/habit_model.dart';

class LocalStorageService {
  static const _habitsKey = 'habits_list';

  Future<void> saveHabits(List<Habit> habits) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = habits.map((h) => h.toJson()).toList();
    await prefs.setStringList(_habitsKey, jsonList);
  }

  Future<List<Habit>> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_habitsKey) ?? [];
    return jsonList.map((j) => Habit.fromJson(j)).toList();
  }
}
