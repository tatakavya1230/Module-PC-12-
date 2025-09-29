import 'dart:io' show Platform; // Safe: we guard with kIsWeb before using
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

// Render different text on Web vs Android
void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: PlatformTextPage()));
}

class PlatformTextPage extends StatelessWidget {
  const PlatformTextPage({super.key});

  String _message() {
    if (kIsWeb) return 'This is for the web!!';
    if (Platform.isAndroid) return 'This is for android!!';
    return 'Unsupported platform for this demo';
  }

  @override
  Widget build(BuildContext context) {
    final bool isWebOrAndroid = kIsWeb || Platform.isAndroid;
    return Scaffold(
      backgroundColor: isWebOrAndroid ? Colors.red : null,
      appBar: AppBar(title: const Text('Platform Text Demo')),
      body: Center(
        child: Text(
          _message(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


