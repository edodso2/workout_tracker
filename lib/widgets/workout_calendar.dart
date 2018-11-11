import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';
import '../widgets/event_calendar/event_calendar.dart';

class WorkoutCalendar extends StatefulWidget {
  @override
  _WorkoutCalendar createState() => _WorkoutCalendar();
}

class _WorkoutCalendar extends State<WorkoutCalendar> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (
        BuildContext context,
        Widget child,
        MainModel model,
      ) {
        return EventCalendar(
          onDateSelected: (DateTime date) {
            final index = model.getWorkoutOnDate(date);
            Navigator.pushNamed(context, '/workouts/$index');
          },
        );
      },
    );
  }
}
