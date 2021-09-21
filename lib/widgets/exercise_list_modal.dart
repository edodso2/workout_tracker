import 'package:flutter/material.dart';

import '../models/exercise.dart';

class ExerciseListModal {
  static Future<Exercise> showListModal(
    BuildContext context,
    List<dynamic> items,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                key: Key('listItem$index'),
                title: Text(
                  /// NOTE: assuming the item has a name. Could create a
                  /// base class later if we need to reuse this for a
                  /// list of items with no 'name' value.
                  items[index].name,
                  style: const TextStyle(fontSize: 16.0),
                ),
                onTap: () {
                  Navigator.pop(context, items[index]);
                },
              );
            },
            itemCount: items.length,
          ),
        );
      },
    );
  }
}
