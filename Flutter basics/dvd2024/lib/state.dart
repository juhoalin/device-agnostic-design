import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
 runApp(MaterialApp(home: Scaffold(body: Center(child: CounterWidget()))));
}

class CounterWidget extends StatefulWidget {
  @override
  State<CounterWidget>  createState() => _CounterState();
}

class _CounterState extends State<CounterWidget> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Current count: $_counter'),
        ElevatedButton(
          onPressed: _increment,
          child: Text('Increment'),
        ),
        ElevatedButton(
          onPressed: _decrement,
          child: Text('Decrement'),
        ),
        ElevatedButton(
          onPressed: _reset,
          child: Text('Reset')
        ),
      ],
    );
  }
}