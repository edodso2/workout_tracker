import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';
import '../models/workout.dart';

/// Allows the user to add workout exercises for
/// a specified date. The date month, day and year
/// should get passed as a route parameter to avoid
/// unecessary state maintenance.
class AddWorkoutExercisesPage extends StatefulWidget {
  final int month;
  final int day;
  final int year;

  AddWorkoutExercisesPage({
    this.month,
    this.day,
    this.year,
  });

  _AddWorkoutExercisesPageState createState() =>
      _AddWorkoutExercisesPageState();
}

class _AddWorkoutExercisesPageState extends State<AddWorkoutExercisesPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (
        BuildContext context,
        Widget child,
        MainModel model,
      ) {
        final DateTime date = DateTime(widget.year, widget.month, widget.day);
        int index = model.getWorkoutOnDate(date);

        return Text('Add Workouts Page');
      },
    );
  }
}
