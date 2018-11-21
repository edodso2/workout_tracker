import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mockito/mockito.dart';

import 'package:workout_tracker/scoped_models/main.dart';

void main() {

  testWidgets(
    'Should show bottom sheet when add button is clicked',
    (WidgetTester tester) async {},
  );
}

class MockMainModel extends Mock implements MainModel {}
