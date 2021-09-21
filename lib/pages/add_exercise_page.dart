import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/exercise.dart';
import '../scoped_models/exercises.dart';

class AddExercisePage extends StatefulWidget {
  const AddExercisePage({Key key}) : super(key: key);

  @override
  _AddExercisePageState createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _form = {
    'name': '',
  };

  void _submitForm(BuildContext context, Function addExercise) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    // save the values of all the form fields
    _formKey.currentState.save();

    // add the new exercise to the scoped model
    final Exercise exercise = Exercise(name: _form['name']);
    addExercise(exercise);

    // go back...
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ExercisesModel exercisesModel = ScopedModel.of<ExercisesModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercise'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                key: const Key('name'),
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Name is required';
                  }

                  return null;
                },
                onSaved: (String value) => _form['name'] = value,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () =>
                    _submitForm(context, exercisesModel.addExercise),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
