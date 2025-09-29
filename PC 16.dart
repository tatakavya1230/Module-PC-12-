import 'package:flutter/material.dart';

// Question 21: Simple drawing app on a white canvas using CustomPainter
void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: SimpleDrawingApp()));
}

class SimpleDrawingApp extends StatefulWidget {
  const SimpleDrawingApp({super.key});

  @override
  State<SimpleDrawingApp> createState() => _SimpleDrawingAppState();
}

class _SimpleDrawingAppState extends State<SimpleDrawingApp> {
  final List<List<Offset>> _strokes = <List<Offset>>[]; // each stroke is a list of points
  List<Offset>? _currentStroke;

  void _startStroke(Offset position) {
    _currentStroke = <Offset>[position];
    _strokes.add(_currentStroke!);
    setState(() {});
  }

  void _appendPoint(Offset position) {
    _currentStroke?.add(position);
    setState(() {});
  }

  void _endStroke() {
    _currentStroke = null;
  }

  void _clear() {
    _strokes.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Drawing (white canvas)'),
        actions: [
          IconButton(onPressed: _clear, icon: const Icon(Icons.clear)),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanStart: (details) => _startStroke(details.localPosition),
            onPanUpdate: (details) => _appendPoint(details.localPosition),
            onPanEnd: (_) => _endStroke(),
            child: CustomPaint(
              painter: _DrawingPainter(strokes: _strokes),
              size: Size.infinite,
              child: Container(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<List<Offset>> strokes;
  _DrawingPainter({required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final List<Offset> stroke in strokes) {
      if (stroke.length < 2) continue;
      final Path path = Path()..moveTo(stroke.first.dx, stroke.first.dy);
      for (int i = 1; i < stroke.length; i++) {
        path.lineTo(stroke[i].dx, stroke[i].dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DrawingPainter oldDelegate) => oldDelegate.strokes != strokes;
}


