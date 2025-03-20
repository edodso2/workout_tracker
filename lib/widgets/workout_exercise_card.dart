import 'package:flutter/material.dart';

import '../widgets/add_workout_set.dart';
import '../models/workout_set.dart';
import '../models/workout_exercise.dart';

class WorkoutExerciseCard extends StatelessWidget {
  final int workoutIndex;
  final int exerciseIndex;
  final WorkoutExercise exercise;

  const WorkoutExerciseCard(
    this.workoutIndex,
    this.exerciseIndex,
    this.exercise, {
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              exercise.name,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10.0),
            ConstrainedBox(
              constraints:
                  const BoxConstraints(minHeight: 30.0, maxHeight: 30.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _buildSetsList(context, exercise.workoutSets),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSetsList(
    BuildContext context,
    List<WorkoutSet> workoutSets,
  ) {
    List<Widget> setsList = [];

    // create the array of chips to display the workout sets
    for (var i = 0; i < workoutSets.length; i++) {
      final WorkoutSet workoutSet = workoutSets[i];

      setsList.add(GestureDetector(
        key: Key('workoutSet$i'),
        onTap: () => {},
        child: Chip(
          label: Text('${workoutSet.reps} x ${workoutSet.weight}'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ));

      setsList.add(const SizedBox(width: 8.0));
    }

    // add the plus icon for adding a new set
    setsList.add(AddWorkoutSet(
      workoutIndex,
      exerciseIndex,
      key: const Key('addWorkoutSet'),
    ));

    return setsList;
  }
}
