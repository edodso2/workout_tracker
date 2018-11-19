import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/widgets/exercise_list_modal.dart';

void main() {
  Exercise exercise1 = Exercise(name: 'Deadlift');
  Exercise exercise2 = Exercise(name: 'Curls');
  List<Exercise> exercises = [
    exercise1,
    exercise2,
  ];

  BuildContext savedContext;
  Widget mockApp = MaterialApp(
    home: Builder(
      builder: (BuildContext context) {
        savedContext = context;
        return Container();
      },
    ),
  );

  testWidgets(
    'Should show modal with exercise list',
    (WidgetTester tester) async {
      await tester.pumpWidget(mockApp);

      ExerciseListModal.showListModal(savedContext, exercises);

      await tester.pump(); // bottom sheet show animation starts
      await tester.pump(const Duration(seconds: 1)); // animation done

      Finder listItemTitle1 = find.text(exercise1.name);

      expect(listItemTitle1, findsOneWidget);
    },
  );

  testWidgets(
    'Should return selected exercise when closed',
    (WidgetTester tester) async {
      Exercise selectedExercise;

      await tester.pumpWidget(mockApp);

      ExerciseListModal.showListModal(savedContext, exercises).then(
        (Exercise value) {
          selectedExercise = value;
        },
      );

      await tester.pump(); // bottom sheet show animation starts
      await tester.pump(const Duration(seconds: 1)); // animation done

      Finder listItem1 = find.byKey(Key('listItem0'));

      await tester.tap(listItem1);

      await tester.pump(); // bottom sheet hide animation starts
      await tester.pump(const Duration(seconds: 1)); // animation done

      expect(selectedExercise, exercise1);
    },
  );
}
