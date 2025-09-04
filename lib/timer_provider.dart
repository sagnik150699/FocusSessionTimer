import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  final int _start = 25 * 60;
  int _current = 25 * 60;
  bool _isRunning = false;

  VoidCallback? onMilestoneReached;
  VoidCallback? onSessionInterrupted;

  int get current => _current;
  bool get isRunning => _isRunning;

  void startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_current > 0) {
        _current--;
        if ((_start - _current) % 300 == 0 && _current != _start) {
          onMilestoneReached?.call();
        }
        notifyListeners();
      } else {
        stopTimer(completed: true);
      }
    });
  }

  void stopTimer({bool completed = false}) {
    _isRunning = false;
    _timer?.cancel();
    if (!completed) {
      onSessionInterrupted?.call();
    }
    notifyListeners();
  }

  void resetTimer() {
    _isRunning = false;
    _timer?.cancel();
    _current = _start;
    notifyListeners();
  }

  String get timeString {
    final minutes = (_current / 60).floor().toString().padLeft(2, '0');
    final seconds = (_current % 60).floor().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
