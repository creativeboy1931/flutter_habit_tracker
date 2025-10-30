import 'dart:convert';

class Habit {
  String id;
  String name;
  DateTime createdAt;
  List<String> completedDates; // store completed dates as 'yyyy-MM-dd' strings

  Habit({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.completedDates,
  });

  bool isCompletedToday() {
    final today = DateTime.now();
    final todayStr = _dateToStr(today);
    return completedDates.contains(todayStr);
  }

  void toggleCompletionToday() {
    final todayStr = _dateToStr(DateTime.now());
    if (completedDates.contains(todayStr)) {
      completedDates.remove(todayStr);
    } else {
      completedDates.add(todayStr);
    }
  }

  int getCurrentStreak() {
    int streak = 0;
    DateTime date = DateTime.now();

    while (completedDates.contains(_dateToStr(date))) {
      streak++;
      date = date.subtract(const Duration(days: 1));
    }
    return streak;
  }

  static String _dateToStr(DateTime date) =>
      '${date.year}-${date.month}-${date.day}';

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'createdAt': createdAt.toIso8601String(),
    'completedDates': completedDates,
  };

  factory Habit.fromMap(Map<String, dynamic> map) => Habit(
    id: map['id'],
    name: map['name'],
    createdAt: DateTime.parse(map['createdAt']),
    completedDates: List<String>.from(map['completedDates']),
  );

  String toJson() => json.encode(toMap());
  factory Habit.fromJson(String source) => Habit.fromMap(json.decode(source));
}
