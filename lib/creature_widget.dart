import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'creature_provider.dart';

class CreatureWidget extends StatelessWidget {
  const CreatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final creatureProvider = Provider.of<CreatureProvider>(context);
    final size = 100 + creatureProvider.growth * 10.0;
    final color = Color.lerp(
      Colors.teal,
      Colors.pinkAccent,
      (creatureProvider.growth / 10).clamp(0.0, 1.0),
    )!;

    return Animate(
      effects: const [
        ScaleEffect(
          duration: Duration(seconds: 2),
          curve: Curves.easeInOut,
          begin: Offset(1, 1),
          end: Offset(1.05, 1.05),
        ),
      ],
      target: 1,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(102),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Eyes
            Positioned(
              top: size * 0.35,
              child: Row(
                children: [
                  _buildEye(size),
                  SizedBox(width: size * 0.2),
                  _buildEye(size),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(reverse: true),
        )
        .scale(
          duration: 2.seconds,
          curve: Curves.easeInOut,
          begin: const Offset(1, 1),
          end: const Offset(1.05, 1.05),
        );
  }

  Widget _buildEye(double size) {
    return Animate(
      effects: const [
        ScaleEffect(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
          begin: Offset(1, 1),
          end: Offset(1, 0.1),
        ),
      ],
      target: 1,
      child: Container(
        width: size * 0.15,
        height: size * 0.15,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    )
        .animate(
          onPlay: (controller) =>
              controller.repeat(period: 3.seconds, reverse: true),
        )
        .scaleY(
          duration: 200.ms,
          curve: Curves.easeOut,
          begin: 1,
          end: 0.1,
        );
  }
}
