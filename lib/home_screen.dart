import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'creature_provider.dart';
import 'creature_widget.dart';
import 'timer_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Use AudioCache for short, pre-loaded sounds - the correct method.
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Pre-load sounds for immediate playback.
    final audioCache = AudioCache(prefix: 'assets/');
    audioCache.loadAll(['click.wav', 'select.wav', 'success.wav']);

    final timerProvider = Provider.of<TimerProvider>(context, listen: false);
    final creatureProvider = Provider.of<CreatureProvider>(
      context,
      listen: false,
    );

    timerProvider.onMilestoneReached = () {
      creatureProvider.grow();
      _playSound('success.wav');
    };

    timerProvider.onSessionInterrupted = () {
      creatureProvider.penalize();
    };
  }

  void _playSound(String soundFile) async {
    // No need for try-catch with AudioCache, as errors are handled internally.
    await _player.play(AssetSource(soundFile));
  }

  @override
  void dispose() {
    _player.dispose(); // Dispose the player when the widget is removed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final timerProvider = Provider.of<TimerProvider>(context);

    final lightGradient = [
      Colors.indigo.shade100,
      Colors.purple.shade100,
    ];
    final darkGradient = [
      Colors.grey.shade900,
      Colors.blueGrey.shade900,
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: themeProvider.themeMode == ThemeMode.light
                ? lightGradient
                : darkGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    themeProvider.themeMode == ThemeMode.dark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                  onPressed: () {
                    themeProvider.toggleTheme();
                    _playSound('click.wav');
                  },
                  tooltip: 'Toggle Theme',
                ).animate().fade(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Focus Pet',
                        style: Theme.of(context).textTheme.titleLarge,
                      ).animate().fade(duration: 500.ms).slideY(),
                      const SizedBox(height: 10),
                      SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(
                            progressBarWidth: 15,
                            trackWidth: 5,
                            handlerSize: timerProvider.isRunning ? 0 : 10,
                          ),
                          customColors: CustomSliderColors(
                            trackColor: Colors.grey.withAlpha(51),
                            progressBarColor:
                                Theme.of(context).colorScheme.primary,
                            dotColor: Theme.of(context).colorScheme.secondary,
                            shadowColor:
                                Theme.of(context).primaryColor.withAlpha(77),
                            shadowMaxOpacity: 0.1,
                          ),
                          infoProperties: InfoProperties(
                            mainLabelStyle: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          startAngle: 270,
                          angleRange: 360,
                        ),
                        min: 5,
                        max: 30,
                        initialValue: timerProvider.start / 60,
                        onChange: (double value) {
                          if (!timerProvider.isRunning) {
                            timerProvider.setTimer(value);
                          }
                        },
                        onChangeEnd: (double value) {
                          if (!timerProvider.isRunning) {
                            _playSound('select.wav');
                          }
                        },
                        innerWidget: (double value) {
                          // Use FittedBox to ensure the text scales down to fit.
                          return FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              timerProvider.timeString,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const CreatureWidget(),
                    ].animate(interval: 200.ms).fade(duration: 500.ms).slideY(
                          begin: 0.2,
                          curve: Curves.easeOut,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!timerProvider.isRunning)
                      ElevatedButton.icon(
                        icon: const Icon(Icons.play_arrow_rounded),
                        onPressed: () {
                          timerProvider.startTimer();
                          _playSound('click.wav');
                        },
                        label: const Text('Start Focusing'),
                      ),
                    if (timerProvider.isRunning)
                      ElevatedButton.icon(
                        icon: const Icon(Icons.stop_rounded),
                        onPressed: () {
                          timerProvider.stopTimer();
                          _playSound('click.wav');
                        },
                        label: const Text('Take a Break'),
                      ),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh_rounded),
                      onPressed: () {
                        timerProvider.resetTimer();
                        _playSound('click.wav');
                      },
                      label: const Text('Reset'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ).animate().fade(delay: 1.seconds),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
