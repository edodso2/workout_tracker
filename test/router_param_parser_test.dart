import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:workout_tracker/router_param_parser.dart';

main() {
  test('should return parsed route with params', () {
    String workoutsPageRouteName = 'workouts';
    RouterParamParser parser = RouterParamParser([
      workoutsPageRouteName,
    ]);
    RouteSettings settings = const RouteSettings(name: '/workouts/1/2/3');
    ParsedRoute? route = parser.parse(settings);

    expect(route!.name, workoutsPageRouteName);
    expect(route.params[0], '1');
    expect(route.params[1], '2');
    expect(route.params[2], '3');
  });
}
