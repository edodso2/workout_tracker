import 'package:flutter/material.dart';

class CalendarDay extends StatelessWidget {
  final DateTime date;
  final bool isMarked;
  final VoidCallback onDateSelected;

  CalendarDay(
    this.date, {
    this.isMarked: false,
    this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Container(
        child: InkWell(
          borderRadius: BorderRadius.circular(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                date.day.toString(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    shape: CircleBorder(),
                    color: isMarked ? Colors.redAccent : Colors.transparent,
                    child: Text(' '),
                  ),
                ],
              ),
            ],
          ),
          onTap: onDateSelected,
        ),
      ),
    );
  }
}
