
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  int _duration = 25 * 60;
  int _current = 25 * 60;
  bool _isRunning = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  VoidCallback? onMilestoneReached;
  VoidCallback? onSessionInterrupted;

  int get current => _current;
  int get duration => _duration;
  bool get isRunning => _isRunning;

  void setDuration(int seconds) {
    if (!_isRunning) {
      _duration = seconds;
      _current = seconds;
      notifyListeners();
    }
  }

  void startTimer() {
    if (_duration > 0 && !_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_current > 0) {
          _current--;
          if ((_duration - _current) % 300 == 0 && _current != _duration) {
            onMilestoneReached?.call();
          }
          notifyListeners();
        } else {
          stopTimer(completed: true);
        }
      });
    }
  }

  void stopTimer({bool completed = false}) {
    if (_isRunning) {
      _isRunning = false;
      _timer?.cancel();
      if (!completed) {
        onSessionInterrupted?.call();
      }
      notifyListeners();
    }
  }

  void resetTimer() {
    _isRunning = false;
    _timer?.cancel();
    _current = _duration;
    notifyListeners();
  }

  Future<void> playClickSound() async {
    try {
      await _audioPlayer.play(AssetSource('audio/click.mp3'));
    } catch (e) {
      // Handle error
    }
  }

  String get timeString {
    final minutes = (_current / 60).floor().toString().padLeft(2, '0');
    final seconds = (_current % 60).floor().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
