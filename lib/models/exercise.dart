import 'package:flutter/material.dart';

class Exercise {
  final String name;

  Exercise({
    @required this.name,
  });

  /// Custom comparator logic below so that even if two objects
  /// are not the same insance they will return true when compared
  /// if there members are equal.
  /// https://medium.com/@ayushpguptaapg/demystifying-and-hashcode-in-dart-2f328d1ab1bc
  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Exercise && name == other.name;

  /// Helper to map the object to valid JSON
  Map<String, Object> toJson() {
    return {
      "name": name,
    };
  }

  /// Helper toc reate an exercise instance from JSON
  static Exercise fromJson(Map<String, Object> json) {
    return Exercise(
      name: json['name'] as String,
    );
  }
}
