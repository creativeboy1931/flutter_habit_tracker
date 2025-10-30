import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarViewer extends StatelessWidget {
  const CalendarViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    DateTime now = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //day
        Text(
          '${now.day},${DateFormat('EEE').format(now)}',
          style: theme.textTheme.titleMedium,
        ),
        //month
        Text(
          DateFormat('MMM').format(now),
          style: theme.textTheme.headlineMedium,
        ),
        //year
        Text(
          DateFormat('yyyy').format(now),
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}
