import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './counter.dart';
import '../scoped_models/workouts.dart';

class AddWorkoutSet extends StatefulWidget {
  final int workoutIndex;
  final int exerciseIndex;

  const AddWorkoutSet(
    this.workoutIndex,
    this.exerciseIndex, {
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddWorkoutSetState();
  }
}

class _AddWorkoutSetState extends State<AddWorkoutSet> {
  int reps;
  int weight;

  @override
  void initState() {
    super.initState();
    reps = 5;
    weight = 135;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WorkoutsModel>(builder: (
      BuildContext context,
      Widget child,
      WorkoutsModel model,
    ) {
      return InkWell(
        key: const Key('addWorkoutSetBtn'),
        child: Icon(
          Icons.add_circle,
          color: Theme.of(context).colorScheme.secondary,
          size: 30.0,
        ),
        borderRadius: BorderRadius.circular(50.0),
        onTap: () {
          showModal(context).then((update) {
            if (update != null && update) {
              model.addWorkoutSet(
                widget.workoutIndex,
                widget.exerciseIndex,
                reps: reps,
                weight: weight,
              );
            }
          });
        },
      );
    });
  }

  Future<dynamic> showModal(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            const SizedBox(height: 15.0),
            Counter(
              startingValue: 5,
              onChanged: (value) {
                setState(() {
                  reps = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            Counter(
              startingValue: 135,
              increment: 5,
              onChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              key: const Key('addSetButton'),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Add Set'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary, // background
                onPrimary: Colors.white, // foreground
              ),
            ),
          ],
        );
      },
    );
  }
}
