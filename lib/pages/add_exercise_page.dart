import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/exercise.dart';
import '../scoped_models/main.dart';

class AddExercisePage extends StatefulWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Exercise'),
      ),
      body: ScopedModelDescendant<MainModel>(builder: (
        BuildContext context,
        Widget child,
        MainModel model,
      ) {
        return Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  key: Key('name'),
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Name is required';
                    }
                  },
                  onSaved: (String value) => _form['name'] = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: Text('Add'),
                  onPressed: () => _submitForm(context, model.addExercise),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
