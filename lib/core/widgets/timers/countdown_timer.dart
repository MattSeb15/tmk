import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int secondsRemaining;
  final ValueChanged<int>? onChanged;
  final bool? isPaused;
  const CountdownTimer(
      {super.key,
      required this.secondsRemaining,
      this.isPaused,
      this.onChanged});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late int _secondsRemaining;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.secondsRemaining;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0 && widget.isPaused == false) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
        }
      });
      if (widget.onChanged == null) return;
      widget.onChanged!(_secondsRemaining);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    String seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, offset: Offset(0, 2), blurRadius: 6)
            ]),
        child: Text(
          '$minutes:$seconds',
          style: TextStyle(
              fontSize: 25,
              color: _secondsRemaining < 60 ? Colors.redAccent : Colors.black),
        ));
  }
}
