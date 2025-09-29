import 'package:flutter/material.dart';

// Question 20: Rotate an image clockwise/anti‑clockwise using a single button
void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: RotateImagePage()));
}

class RotateImagePage extends StatefulWidget {
  const RotateImagePage({super.key});

  @override
  State<RotateImagePage> createState() => _RotateImagePageState();
}

class _RotateImagePageState extends State<RotateImagePage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _clockwise = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDirection() {
    setState(() {
      _clockwise = !_clockwise;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> turns = _clockwise ? _controller : ReverseAnimation(_controller);

    return Scaffold(
      appBar: AppBar(title: const Text('Clockwise / Anti‑clockwise Rotation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 220,
              width: 220,
              child: RotationTransition(
                turns: turns,
                child: ClipOval(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Clock_simple_white.svg/240px-Clock_simple_white.svg.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stack) => const Icon(Icons.access_time, size: 180),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _toggleDirection,
              icon: const Icon(Icons.rotate_right),
              label: Text(_clockwise ? 'Rotate Anti‑clockwise' : 'Rotate Clockwise'),
            ),
          ],
        ),
      ),
    );
  }
}


