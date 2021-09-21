import 'dart:convert';
import 'dart:io';

import './doc_reader_service.dart';
import './exercise_service.dart';
import '../models/exercise.dart';

class ExerciseServiceFlutter extends ExerciseService {
  final Future<Directory> Function() getDirectory;
  DocReaderService docReaderService;

  ExerciseServiceFlutter(
    this.getDirectory,
  ) {
    docReaderService = DocReaderService(getDirectory, 'ExerciseStorage');
  }

  @override
  Future<List<Exercise>> loadExercises() async {
    final json = await docReaderService.readFromDisk();
    final exercises = (json['exercises'])
        .map<Exercise>((exercise) => Exercise.fromJson(exercise))
        .toList();

    return exercises;
  }

  @override
  Future<File> saveExercises(List<Exercise> exercises) async {
    final String json = const JsonEncoder().convert({
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    });

    return docReaderService.writeToDisk(json);
  }
}
