import 'package:flutter/material.dart';

class CalendarDay extends StatelessWidget {
  final DateTime date;
  final bool isMarked;
  final VoidCallback onDateSelected;

  const CalendarDay(
    this.date, {
    super.key,
    this.isMarked = false,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final String day = date.day.toString();

    return Container(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(50.0),
        child: Column(
          key: Key('day$day'),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              day,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  shape: const CircleBorder(),
                  color: isMarked ? Colors.redAccent : Colors.transparent,
                  child: const Text(' '),
                ),
              ],
            ),
          ],
        ),
        onTap: onDateSelected,
      ),
    );
  }
}
