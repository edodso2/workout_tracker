import 'package:flutter/material.dart';

/// I tried to make this widget stateless similar to
/// how the default flutter slider/checkbox works but
/// it would not update the UI via setState call when
/// user bottom sheet. Not sure if this is an issue
/// or intended but for now this widget will be stateful.
/// UPDATE:
/// Below link seems to address this issue.
/// https://github.com/flutter/flutter/issues/2115
class Counter extends StatefulWidget {
  final Function onChanged;
  final int increment;
  final int startingValue;

  const Counter({
    Key key,
    this.startingValue = 0,
    this.onChanged,
    this.increment = 1,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CounterState();
  }
}

class _CounterState extends State<Counter> {
  int value;

  @override
  void initState() {
    super.initState();
    value = widget.startingValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.remove_circle_outline,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: _subtract,
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: _add,
        ),
      ],
    );
  }

  void _subtract() {
    // extra logic for preventing negative values
    int newValue = value - widget.increment;
    if (newValue < 0) {
      newValue = 0;
    }
    setState(() {
      value = newValue;
      widget.onChanged(value);
    });
  }

  void _add() {
    setState(() {
      value = value + widget.increment;
      widget.onChanged(value);
    });
  }
}
