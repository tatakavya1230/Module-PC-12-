import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LuckyNumberPage(),
  ));
}

class LuckyNumberPage extends StatefulWidget {
  const LuckyNumberPage({super.key});

  @override
  State<LuckyNumberPage> createState() => _LuckyNumberPageState();
}

class _LuckyNumberPageState extends State<LuckyNumberPage> {
  int? _luckyNumber;

  // Hint 1: Method to generate random lucky number up to 350 (1..350)
  int _generateLuckyNumber() {
    return Random().nextInt(350) + 1; // 0..349 -> 1..350
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Lucky Number'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hint 2: Text to display the lucky number
            Text(
              _luckyNumber == null
                  ? 'Tap the button to get your lucky number (1-350)'
                  : 'Your lucky number is: $_luckyNumber',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            // Hint 2: ElevatedButton to trigger generation
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _luckyNumber = _generateLuckyNumber();
                });
              },
              icon: const Icon(Icons.casino),
              label: const Text('Get Lucky Number'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
            ),
          ],
        ),
      ),
    );
  }
}


