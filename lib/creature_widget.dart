import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'creature_provider.dart';

class CreatureWidget extends StatelessWidget {
  const CreatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final creatureProvider = Provider.of<CreatureProvider>(context);

    return Icon(
      Icons.eco,
      size: 100 + creatureProvider.growth * 10.0,
      color: Colors.green,
    );
  }
}
