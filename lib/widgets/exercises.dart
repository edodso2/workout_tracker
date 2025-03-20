import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/exercises.dart';

class Exercises extends StatelessWidget {
  const Exercises({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ExercisesModel>(builder: (
      BuildContext context,
      Widget? child,
      ExercisesModel model,
    ) {
      return Container(
        margin: const EdgeInsets.only(bottom: 30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Text(model.exercises[index].name),
                  );
                },
                itemCount: model.exercises.length,
              ),
            ),
            ElevatedButton(
              child: const Text('Add Excercise'),
              onPressed: () {
                Navigator.pushNamed(context, '/addExercise');
              },
            )
          ],
        ),
      );
    });
  }
}
