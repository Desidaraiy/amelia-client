import 'package:flutter/material.dart';
import 'package:markets/src/components/AddRemoveWidget.dart';
import 'package:markets/src/helpers/colors.dart';

class Counter extends StatefulWidget {
  Counter({Key key, this.counter, this.handleCounter}) : super(key: key);
  int counter;
  final void Function(int) handleCounter;
  @override
  _CounterState createState() => _CounterState();
}

//максимум
class _CounterState extends State<Counter> {
  int _counter;
  @override
  void didChangeDependencies() {
    _counter = widget.counter;
    super.didChangeDependencies();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      widget.handleCounter(_counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      widget.handleCounter(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.counter == 1
            ? SizedBox(
                width: 32,
                child: SwitchButton(
                  add: false,
                  minimum: true,
                ),
              )
            : InkWell(
                onTap: _decrementCounter,
                child: SizedBox(
                  width: 32,
                  child: SwitchButton(
                    add: false,
                    minimum: false,
                  ),
                ),
              ),
        Container(
          width: 36,
          child: Text(
            widget.counter.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .merge(TextStyle(color: neutral_500)),
          ),
        ),
        InkWell(
          onTap: _incrementCounter,
          child: SizedBox(
            width: 32,
            child: SwitchButton(
              add: true,
              minimum: false,
            ),
          ),
        ),
      ],
    );
  }
}
