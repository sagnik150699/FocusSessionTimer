
import 'package:flutter/material.dart';

class CreatureProvider with ChangeNotifier {
  double _growth = 0.0;
  final List<Particle> _particles = [];

  double get growth => _growth;
  List<Particle> get particles => _particles;

  void grow() {
    _growth += 0.1;
    if (_growth > 1.0) {
      _growth = 1.0;
    }
    _addParticles();
    notifyListeners();
  }

  void penalize() {
    _growth -= 0.2;
    if (_growth < 0.0) {
      _growth = 0.0;
    }
    notifyListeners();
  }

  void _addParticles() {
    for (int i = 0; i < 10; i++) {
      _particles.add(Particle());
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      _particles.clear();
      notifyListeners();
    });
  }
}

class Particle {
  final double x;
  final double y;

  Particle() 
      : x = (DateTime.now().millisecond / 1000) * 2 - 1,
        y = (DateTime.now().millisecond / 1000) * 2 - 1;
}
