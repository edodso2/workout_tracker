import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/models/workout_exercise.dart';
import 'package:workout_tracker/pages/workouts_page.dart';
import 'package:workout_tracker/scoped_models/main.dart';

/// TODO: the grouping in this file is ok but makes it a bit hard to read.
/// I prefer the approach I used for the workout_exercise_card_test file
/// where a utility function and global variables are used to modularize
/// the test as opposed to the 'group' function. Should refactor in future.

/// This file will contain UI tests for the add exercise widget page
/// and will mock the MainModel. The MainModel is tested under the
/// model_tests folder.
void main() {
  /// All of the tests in this file can use the same model since
  /// it is mocked. Can also use the same date for all the tests
  /// and simply return different values from the mocked model
  /// using Mockito.
  MainModel model = MockMainModel();
  final year = 2018;
  final month = 11;
  final day = 5;
  final date = DateTime(2018, 11, 5);

  group('Workout not found', () {
    testWidgets(
      'should display message and create button',
      (WidgetTester tester) async {
        Widget mockApp = TestUtil.createMockApp(model, year, month, day);

        when(model.getWorkoutOnDate(date)).thenReturn(-1);

        await tester.pumpWidget(mockApp);

        Key messageKey = Key('noWorkoutMessage');
        Finder message = find.byKey(messageKey);

        Key buttonKey = Key('createButton');
        Finder button = find.byKey(buttonKey);

        expect(message, findsOneWidget);
        expect(button, findsOneWidget);
      },
    );
    testWidgets(
      'should call createWorkout function when create button clicked',
      (WidgetTester tester) async {
        Widget mockApp = TestUtil.createMockApp(model, year, month, day);

        when(model.getWorkoutOnDate(date)).thenReturn(-1);

        await tester.pumpWidget(mockApp);

        Key buttonKey = Key('createButton');
        Finder button = find.byKey(buttonKey);

        await tester.tap(button);

        verify(model.createWorkout(date)).called(1);
      },
    );
  });
  group('Workout found', () {
    group('Exercises not found', () {
      Widget mockApp;
      List<Workout> workouts;

      setUp(() {
        mockApp = TestUtil.createMockApp(model, year, month, day);
        workouts = [Workout(date: date, workoutExercises: [])];
        when(model.getWorkoutOnDate(date)).thenReturn(0);
        when(model.workouts).thenReturn(workouts);
      });

      testWidgets(
        'should display no exercises message',
        (WidgetTester tester) async {
          await tester.pumpWidget(mockApp);

          Key messageKey = Key('noExercisesMessage');
          Finder message = find.byKey(messageKey);

          expect(message, findsOneWidget);
        },
      );
      testWidgets(
        'should display add exercies button',
        (WidgetTester tester) async {
          // test is used twice so extracting into util function
          TestUtil.checkForAddExerciseWidget(tester, mockApp);
        },
      );
    });
    group('Exercises found', () {
      Widget mockApp;
      List<WorkoutExercise> workoutExercises;
      List<Workout> workouts;

      setUp(() {
        mockApp = TestUtil.createMockApp(model, year, month, day);
        workoutExercises = [
          WorkoutExercise(name: 'Deadlift', workoutSets: []),
          WorkoutExercise(name: 'Bench Press', workoutSets: []),
        ];
        workouts = [
          Workout(date: date, workoutExercises: workoutExercises),
        ];
        when(model.getWorkoutOnDate(date)).thenReturn(0);
        when(model.workouts).thenReturn(workouts);
      });

      testWidgets(
        'should display exercises',
        (WidgetTester tester) async {
          /// This test should just ensure the exercise card is there.
          /// the exercise card widget test will ensure the exercise is
          /// displayed correctly
          await tester.pumpWidget(mockApp);

          Finder exercise1 = find.text('Deadlift');
          Finder exercise2 = find.text('Bench Press');

          expect(exercise1, findsOneWidget);
          expect(exercise2, findsOneWidget);
        },
      );
      testWidgets(
        'should display add exercies button',
        (WidgetTester tester) async {
          // test is used twice so extracting into util function
          TestUtil.checkForAddExerciseWidget(tester, mockApp);
        },
      );
    });
  });
}

class MockMainModel extends Mock implements MainModel {}

class TestUtil {
  static Widget createMockApp(model, year, month, day) {
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        home: WorkoutsPage(year: year, month: month, day: day),
      ),
    );
  }

  static void checkForAddExerciseWidget(
    WidgetTester tester,
    Widget mockApp,
  ) async {
    await tester.pumpWidget(mockApp);

    Key widgetKey = Key('addWorkoutExerciseWidget');
    Finder widget = find.byKey(widgetKey);

    expect(widget, findsOneWidget);
  }
}
