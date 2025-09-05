
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final timerProvider = Provider.of<TimerProvider>(context, listen: false);
    final creatureProvider = Provider.of<CreatureProvider>(context, listen: false);

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
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[850] : Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Focus Session Timer'),
        actions: [
          Tooltip(
            message: 'Toggle Theme',
            child: IconButton(
              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () {
                HapticFeedback.mediumImpact();
                themeProvider.toggleTheme();
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withAlpha(isDarkMode ? 50 : 25),
              Theme.of(context).colorScheme.surface.withAlpha(isDarkMode ? 10 : 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Set Your Focus Time',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      size: 250,
                      customWidths: CustomSliderWidths(
                        trackWidth: 12,
                        progressBarWidth: 20,
                        handlerSize: 8,
                      ),
                      customColors: CustomSliderColors(
                        trackColor: Theme.of(context).colorScheme.primary.withAlpha(50),
                        progressBarColor: Theme.of(context).colorScheme.primary,
                        dotColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                      infoProperties: InfoProperties(
                        mainLabelStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 48,
                              letterSpacing: 0,
                            ),
                        modifier: (double value) {
                          final minutes = (value / 60).floor().toString().padLeft(2, '0');
                          final seconds = (value % 60).floor().toString().padLeft(2, '0');
                          return '$minutes:$seconds';
                        },
                      ),
                    ),
                    min: 0,
                    max: 3600,
                    initialValue: timerProvider.duration.toDouble(),
                    onChange: (double value) {
                      timerProvider.setDuration(value.toInt());
                    },
                  ),
                  const SizedBox(height: 40),
                  const CreatureWidget(),
                  const SizedBox(height: 50),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      if (!timerProvider.isRunning)
                        Tooltip(
                          message: 'Start a new focus session',
                          child: ElevatedButton.icon(
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              timerProvider.startTimer();
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Start Focusing'),
                          ),
                        ),
                      if (timerProvider.isRunning)
                        Tooltip(
                          message: 'Stop the current session (penalty)',
                          child: ElevatedButton.icon(
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              timerProvider.stopTimer();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade400,
                              foregroundColor: Colors.white,
                            ),
                            icon: const Icon(Icons.stop),
                            label: const Text('Give Up'),
                          ),
                        ),
                      Tooltip(
                        message: 'Reset the timer',
                        child: ElevatedButton.icon(
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            timerProvider.resetTimer();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade400,
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
