import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'creature_provider.dart';
import 'creature_widget.dart';
import 'main.dart';
import 'timer_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final timerProvider = Provider.of<TimerProvider>(context, listen: false);
    final creatureProvider = Provider.of<CreatureProvider>(
      context,
      listen: false,
    );

    timerProvider.onMilestoneReached = () {
      creatureProvider.grow();
    };

    timerProvider.onSessionInterrupted = () {
      creatureProvider.penalize();
    };
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final timerProvider = Provider.of<TimerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Session Timer'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to your focus session!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              timerProvider.timeString,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20),
            const CreatureWidget(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!timerProvider.isRunning)
                  ElevatedButton(
                    onPressed: () => timerProvider.startTimer(),
                    child: const Text('Start Session'),
                  ),
                if (timerProvider.isRunning)
                  ElevatedButton(
                    onPressed: () => timerProvider.stopTimer(),
                    child: const Text('Stop Session'),
                  ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => timerProvider.resetTimer(),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
