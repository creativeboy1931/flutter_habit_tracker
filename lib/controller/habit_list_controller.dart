import 'package:flutter_habit_tracker/data/model/habit_model.dart';
import 'package:flutter_habit_tracker/data/services/local_storage_services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class HabitListController extends GetxController {
  final habits = <Habit>[].obs;
  final _storage = LocalStorageService();

  @override
  void onInit() {
    super.onInit();
    loadHabits();
  }

  Future<void> loadHabits() async {
    habits.value = await _storage.loadHabits();
  }

  Future<void> addHabit(String name) async {
    final newHabit = Habit(
      id: const Uuid().v4(),
      name: name,
      createdAt: DateTime.now(),
      completedDates: [],
    );
    habits.add(newHabit);
    await _storage.saveHabits(habits);
  }

  Future<void> toggleHabitCompletion(Habit habit) async {
    habit.toggleCompletionToday();
    habits.refresh();
    await _storage.saveHabits(habits);
  }
}
