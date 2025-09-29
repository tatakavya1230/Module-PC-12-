import 'package:flutter/material.dart';

// You would typically run this in your main function
void main() {
  runApp(const MaterialApp(home: DateRangeSelector()));
}

class DateRangeSelector extends StatefulWidget {
  const DateRangeSelector({super.key});

  @override
  State<DateRangeSelector> createState() => _DateRangeSelectorState();
}

class _DateRangeSelectorState extends State<DateRangeSelector> {
  // 1. Define Initial Dates
  DateTime _startDate = DateTime.now();
  // Automatically calculate the end date based on the constraint
  DateTime get _endDate => _startDate.subtract(const Duration(days: 29));

  // Function to show the Date Picker and update the state
  Future<void> _selectDate(BuildContext context) async {
    // 2. Define the End Date Constraint for the picker's selectable range
    final DateTime earliestSelectableDate = DateTime(1900); // A far past date
    final DateTime latestSelectableDate = DateTime.now().add(const Duration(days: 365)); // A far future date

    final DateTime? picked = await showDatePicker(
      context: context,
      // The current selected date
      initialDate: _startDate,
      // Earliest date the user can select
      firstDate: earliestSelectableDate,
      // Latest date the user can select
      lastDate: latestSelectableDate,
      helpText: 'Select Start Date',
    );

    // 4. Handle User Selection
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        // The _endDate getter handles the -29 days logic automatically
      });
    }
  }

  // Helper to format the date for display
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Range Picker'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Display Start Date
              Text(
                'Start Date: ${_formatDate(_startDate)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              // Display End Date (29 days ago)
              Text(
                'End Date (29 days prior): ${_formatDate(_endDate)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Button to trigger the Date Picker
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select New Start Date'),
              ),
              const SizedBox(height: 10),
              const Text(
                '*The End Date is automatically calculated to be 29 days before the Start Date.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}