import 'dart:async';
import 'package:flutter/material.dart';

// Question 18: Simple clock using only a Timer; runs for 1 second.
void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: OneSecondClock()));
}

class OneSecondClock extends StatefulWidget {
  const OneSecondClock({super.key});

  @override
  State<OneSecondClock> createState() => _OneSecondClockState();
}

class _OneSecondClockState extends State<OneSecondClock> {
  late DateTime _now;
  Timer? _timer;
  int _ticks = 0;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    // Start a 1-second periodic timer, but cancel after the first tick
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _now = DateTime.now();
        _ticks++;
      });
      // Stop after 1 update as per requirement
      if (_ticks >= 1) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(DateTime t) {
    final two = (int n) => n.toString().padLeft(2, '0');
    return '${two(t.hour)}:${two(t.minute)}:${two(t.second)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('One-Second Clock')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Current time (updates once after 1 second):'),
            const SizedBox(height: 12),
            Text(
              _formatTime(_now),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Text('Ticks: $_ticks'),
          ],
        ),
      ),
    );
  }
}