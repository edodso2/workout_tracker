import 'package:flutter/material.dart';

import 'package:date_utils/date_utils.dart' as utils;
import './calendar_day.dart';

class EventCalendar extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;
  final DateTime date;
  final List<DateTime> markedDates;

  const EventCalendar({
    Key key,
    this.date,
    this.onDateSelected,
    this.markedDates,
  }) : super(key: key);

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  DateTime currentDate;

  @override
  void initState() {
    super.initState();
    if (widget.date == null) {
      currentDate = DateTime.now();
    } else {
      currentDate = widget.date;
    }
  }

  void previousMonth(DateTime selectedDate) {
    setState(() {
      currentDate = utils.DateUtils.previousMonth(selectedDate);
    });
  }

  void nextMonth(DateTime selectedDate) {
    setState(() {
      currentDate = utils.DateUtils.nextMonth(selectedDate);
    });
  }

  Widget buildHeader(DateTime selectedDate) {
    // The formatMonth method returns the full month and year
    // with a space in between so workaround below extracts month
    // and year separately.
    List monthAndYear = utils.DateUtils.formatMonth(selectedDate).split(' ');
    String month = monthAndYear[0];
    String year = monthAndYear[1];

    TextStyle headerTextStyle = const TextStyle(fontSize: 18.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => previousMonth(selectedDate),
        ),
        // nesting another row to get the spacing right.
        Row(
          children: <Widget>[
            Text(month + ' ', style: headerTextStyle),
            Text(year, style: headerTextStyle),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => nextMonth(selectedDate),
        ),
      ],
    );
  }

  List<Widget> buildDays(selectedDate) {
    final List<DateTime> datesOfMonth =
        utils.DateUtils.daysInMonth(selectedDate);
    return datesOfMonth.map(
      (date) {
        /**
         * Need to check if the date is in the selected month.
         * otherwise hide it.
         * NOTE: the daysInMonth util function makes this very
         * easy since it returns a List of all the days that 
         * should be shown in the calendar view for the month
         * so that all the rows have seven dates in them.
         */
        if (date.month == selectedDate.month) {
          return CalendarDay(
            date,
            isMarked: widget.markedDates.contains(date),
            onDateSelected: () {
              setState(() {
                widget.onDateSelected(date);
                currentDate = date;
              });
            },
          );
        } else {
          return const Text('');
        }
      },
    ).toList();
  }

  List<Widget> buildWeekdays() {
    return utils.DateUtils.weekdays.map(
      (weekday) {
        return Center(
          child: Text(
            weekday,
            textAlign: TextAlign.center,
          ),
        );
      },
    ).toList();
  }

  Widget buildCalendar(selectedDate) {
    List<Widget> gridChildren = [
      ...buildWeekdays(),
      ...buildDays(selectedDate)
    ];

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      // setting to 1.01 to fix error:
      // https://github.com/flutter/flutter/issues/16125
      childAspectRatio: 1.01,
      children: gridChildren,
      padding: const EdgeInsets.only(top: 5.0, bottom: 0.0),
      physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        buildHeader(currentDate),
        buildCalendar(currentDate),
      ],
    );
  }
}
