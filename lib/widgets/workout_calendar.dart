import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/workout.dart';
import '../scoped_models/workouts.dart';
import '../widgets/event_calendar/event_calendar.dart';

class WorkoutCalendar extends StatefulWidget {
  @override
  _WorkoutCalendar createState() => _WorkoutCalendar();
}

class _WorkoutCalendar extends State<WorkoutCalendar> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WorkoutsModel>(
      builder: (
        BuildContext context,
        Widget child,
        WorkoutsModel model,
      ) {
        List<DateTime> markedDates = model.workouts.map((Workout workout) {
          return workout.date;
        }).toList();

        return EventCalendar(
          markedDates: markedDates,
          onDateSelected: (DateTime date) {
            final year = date.year;
            final month = date.month;
            final day = date.day;

            Navigator.pushNamed(context, '/workouts/$year/$month/$day');
          },
        );
      },
    );
  }
}
