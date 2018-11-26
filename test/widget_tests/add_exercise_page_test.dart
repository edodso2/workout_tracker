import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/pages/add_exercise_page.dart';
import 'package:workout_tracker/scoped_models/exercises.dart';

/// This file will contain UI tests for the add exercise widget page
/// and will mock the MainModel. The MainModel is tested under the
/// model_tests folder.
void main() {
  testWidgets('Adding exercise smoke test', (WidgetTester tester) async {
    ExercisesModel model = MockMainModel();
    Widget mockApp = ScopedModel<ExercisesModel>(
      model: model,
      child: MaterialApp(home: AddExercisePage()),
    );

    await tester.pumpWidget(mockApp);

    Finder nameField = find.byKey(Key('name'));
    await tester.enterText(nameField, 'Curls');

    await tester.tap(find.text('Add'));

    verify(model.addExercise(Exercise(name: 'Curls'))).called(1);
  });
}

class MockMainModel extends Mock implements ExercisesModel {}
