import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ToggleContentPage(),
  ));
}

enum ContentType { image, details }

class ToggleContentPage extends StatefulWidget {
  const ToggleContentPage({super.key});

  @override
  State<ToggleContentPage> createState() => _ToggleContentPageState();
}

class _ToggleContentPageState extends State<ToggleContentPage> {
  // Hint 1: flag to show different data
  ContentType _current = ContentType.image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toggle Image / Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _current = ContentType.image);
                    },
                    child: const Text('A: Show Image'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() => _current = ContentType.details);
                    },
                    child: const Text('B: Show Details'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: _current == ContentType.image
                    ? _buildImageView()
                    : _buildDetailsView(),
              ),
            ),

            const SizedBox(height: 12),

            // Helper note about assets setup
            const Text(
              'Note: Place an image at assets/images/sample.png and add it to pubspec.yaml under flutter.assets.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // Hint 3: Image view for ContentType.image
  Widget _buildImageView() {
    return Container(
      key: const ValueKey('image'),
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 1.6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/sample.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: const Text('Image not found: assets/images/sample.png'),
              );
            },
          ),
        ),
      ),
    );
  }

  // Hint 2: Text in a Column for details
  Widget _buildDetailsView() {
    return Container(
      key: const ValueKey('details'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Name: John Doe', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text('Phone: +1 555-0123', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Email: john.doe@example.com', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}


