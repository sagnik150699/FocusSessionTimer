
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'creature_provider.dart';

class CreatureWidget extends StatelessWidget {
  const CreatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final creatureProvider = Provider.of<CreatureProvider>(context);
    final size = 20.0 + creatureProvider.growth * 50;

    return LoopAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 1.05),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (creatureProvider.particles.isNotEmpty)
            ..._buildParticles(context, size, creatureProvider.particles),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.lerp(
                Colors.green.shade200,
                Colors.purple.shade400,
                creatureProvider.growth,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withAlpha(150),
                  blurRadius: size * 0.8,
                  spreadRadius: size * 0.2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildParticles(BuildContext context, double creatureSize, List<Particle> particles) {
    return particles.map((particle) {
      final size = Random().nextDouble() * 10 + 5;
      final angle = Random().nextDouble() * 2 * pi;
      final distance = creatureSize / 2 + Random().nextDouble() * 40;

      return PlayAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 600),
        delay: Duration(milliseconds: Random().nextInt(300)),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(
              cos(angle) * (distance * value),
              sin(angle) * (distance * value),
            ),
            child: Opacity(
              opacity: 1.0 - value,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          );
        },
      );
    }).toList();
  }
}
