import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EcommerceProductLayout(),
  ));
}

class EcommerceProductLayout extends StatelessWidget {
  const EcommerceProductLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-commerce Product Layout Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade600, Colors.blue.shade800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'E-commerce Product Layout Problem',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Showcase products in rows that automatically align to next section on tablet/mobile',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Test Case 1: Wrap Widget (CORRECT SOLUTION)
            _buildTestCase(
              title: 'Wrap Widget',
              subtitle: '',
              description: 'Products automatically wrap to next line when screen is too small',
              isCorrect: true,
              child: _buildWrapLayout(),
            ),
            
            const SizedBox(height: 30),
            
            // Test Case 2: SingleChildScrollView with Row (INCORRECT SOLUTION)
            _buildTestCase(
              title: ' SingleChildScrollView with Row',
              subtitle: '',
              description: 'Products overflow horizontally and require scrolling',
              isCorrect: false,
              child: _buildRowLayout(),
            ),
            
            const SizedBox(height: 30),
            
            // Code Examples
            _buildCodeExamples(),
          ],
        ),
      ),
    );
  }

  Widget _buildTestCase({
    required String title,
    required String subtitle,
    required String description,
    required bool isCorrect,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: isCorrect ? Colors.green : Colors.red,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(12),
        color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
        boxShadow: [
          BoxShadow(
            color: (isCorrect ? Colors.green : Colors.red).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isCorrect ? Colors.green.shade800 : Colors.red.shade800,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isCorrect ? Colors.green.shade600 : Colors.red.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  // CORRECT SOLUTION: Wrap Widget
  Widget _buildWrapLayout() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Wrap Widget Implementation:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16.0, // Horizontal spacing between products
            runSpacing: 16.0, // Vertical spacing between rows
            children: _buildProductCards(),
          ),
        ],
      ),
    );
  }

  // INCORRECT SOLUTION: SingleChildScrollView with Row
  Widget _buildRowLayout() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SingleChildScrollView with Row Implementation:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _buildProductCards(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildProductCards() {
    return List.generate(6, (index) {
      return Container(
        width: 180, // Fixed width for demonstration
        height: 220,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade300, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                Icons.shopping_bag,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Product ${index + 1}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${(index + 1) * 29}.99',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCodeExamples() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: Colors.blue.shade600, size: 24),
              const SizedBox(width: 8),
              Text(
                'Code Examples',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Wrap Widget Code
          _buildCodeBlock(
            title: ' ',
            code: '''Wrap(
  spacing: 16.0,       
  runSpacing: 16.0,    
  children: [
    // Your product widgets here
    ProductCard(),
    ProductCard(),
    ProductCard(),
    // ... more products
  ],
)''',
            isCorrect: true,
          ),
          
          const SizedBox(height: 20),
          
          // Row Widget Code
          _buildCodeBlock(
            title: 'Test Case 2: SingleChildScrollView with Row (Not Recommended)',
            code: '''SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      // Your product widgets here
      ProductCard(),
      ProductCard(),
      ProductCard(),
      // ... more products
    ],
  ),
)''',
            isCorrect: false,
          ),
          
          const SizedBox(height: 20),
          
          // Explanation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Why Wrap is the Correct Solution:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 12),
                _buildReason('✓ Automatic responsive behavior'),
                _buildReason('✓ No horizontal overflow'),
                _buildReason('✓ Clean layout on all screen sizes'),
                _buildReason('✓ No manual breakpoint management'),
                _buildReason('✓ Better user experience on mobile'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBlock({
    required String title,
    required String code,
    required bool isCorrect,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCorrect ? Colors.green : Colors.red,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isCorrect ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            code,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReason(String reason) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        reason,
        style: TextStyle(
          fontSize: 14,
          color: Colors.blue.shade700,
        ),
      ),
    );
  }
}
