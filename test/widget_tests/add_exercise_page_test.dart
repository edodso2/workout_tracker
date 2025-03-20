import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:workout_tracker/pages/add_exercise_page.dart';
import 'package:workout_tracker/scoped_models/exercises.dart';

import '../_shared/test_utility.dart';
import '../model_tests/exercise_model_test.mocks.dart';

void main() {
  late MockExercisesModel mockExercisesModel;
  late MockExerciseService mockExerciseService;

  setUp(() {
    mockExerciseService = MockExerciseService();
    mockExercisesModel = MockExercisesModel(exerciseService: mockExerciseService);
  });

  testWidgets('Add exercise form should add an exercise when submitted', 
      (WidgetTester tester) async {
    // Create a MaterialApp wrapped with ScopedModel to provide the mocked model
    await tester.pumpWidget(
      MaterialApp(
        home: ScopedModel<ExercisesModel>(
          model: mockExercisesModel,
          child: const AddExercisePage(),
        ),
      ),
    );

    // Act - Fill the form and submit
    const testExerciseName = 'Push-ups';
    
    // Find the name input field and enter text
    final nameField = find.byKey(const Key('name'));
    expect(nameField, findsOneWidget);
    await tester.enterText(nameField, testExerciseName);
    
    // Find and tap the Add button
    final addButton = find.text('Add');
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    // Assert - Verify the addExercise method was called with correct data
    expect(mockExercisesModel.addExerciseCalls.length, 1);
    expect(mockExercisesModel.addExerciseCalls.first.name, equals(testExerciseName));

    // Verify navigation occurred (should be popped back)
    expect(find.byType(AddExercisePage), findsNothing);
  });
}
