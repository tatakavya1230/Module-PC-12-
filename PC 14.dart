import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// DATA_MODEL
class FormData extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phoneNumber = '';

  String get firstName => _firstName;
  set firstName(String value) {
    if (_firstName != value) {
      _firstName = value;
      notifyListeners();
    }
  }

  String get lastName => _lastName;
  set lastName(String value) {
    if (_lastName != value) {
      _lastName = value;
      notifyListeners();
    }
  }

  String get email => _email;
  set email(String value) {
    if (_email != value) {
      _email = value;
      notifyListeners();
    }
  }

  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) {
    if (_phoneNumber != value) {
      _phoneNumber = value;
      notifyListeners();
    }
  }

  @override
  String toString() {
    return 'First Name: $_firstName, Last Name: $_lastName, Email: $_email, Phone Number: $_phoneNumber';
  }
}

void main() {
  runApp(
    ChangeNotifierProvider<FormData>(
      create: (context) => FormData(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FormQ19Page(),
      ),
    ),
  );
}

class FormQ19Page extends StatefulWidget {
  const FormQ19Page({super.key});

  @override
  State<FormQ19Page> createState() => _FormQ19PageState();
}

class _FormQ19PageState extends State<FormQ19Page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Custom validator functions
  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  String? _minLengthValidator(String? value, int minLength) {
    if (value != null && value.length < minLength) {
      return 'Must be at least $minLength characters.';
    }
    return null;
  }

  String? _maxLengthValidator(String? value, int maxLength) {
    if (value != null && value.length > maxLength) {
      return 'Cannot exceed $maxLength characters.';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  String? _phoneNumberFormatValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    final reg = RegExp(r'^[6-9][0-9]{9}$'); // Assumes 10-digit number starting with 6-9
    if (!reg.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number (starts with 6-9).';
    }
    return null;
  }

  // Combined validators for each field
  String? _firstNameCombinedValidator(String? value) {
    String? error = _requiredValidator(value);
    if (error != null) return error;
    error = _minLengthValidator(value, 5);
    if (error != null) return error;
    error = _maxLengthValidator(value, 15);
    return error;
  }

  String? _lastNameCombinedValidator(String? value) {
    String? error = _requiredValidator(value);
    if (error != null) return error;
    error = _minLengthValidator(value, 5);
    if (error != null) return error;
    error = _maxLengthValidator(value, 15);
    return error;
  }

  String? _emailCombinedValidator(String? value) {
    String? error = _requiredValidator(value);
    if (error != null) return error;
    error = _emailValidator(value);
    return error;
  }

  String? _phoneNumberCombinedValidator(String? value) {
    String? error = _requiredValidator(value);
    if (error != null) return error;
    // The format validator implicitly checks for numeric and 10-digit length
    error = _phoneNumberFormatValidator(value);
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile Form')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'First Name', border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
                  validator: _firstNameCombinedValidator,
                  onChanged: (value) {
                    Provider.of<FormData>(context, listen: false).firstName = value;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Last Name', border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
                  validator: _lastNameCombinedValidator,
                  onChanged: (value) {
                    Provider.of<FormData>(context, listen: false).lastName = value;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _emailCombinedValidator,
                  onChanged: (value) {
                    Provider.of<FormData>(context, listen: false).email = value;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: _phoneNumberCombinedValidator,
                  onChanged: (value) {
                    Provider.of<FormData>(context, listen: false).phoneNumber = value;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final formData = Provider.of<FormData>(context, listen: false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Form is Valid! ${formData.toString()}')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please correct the errors in the form.')),
                      );
                    }
                  },
                  child: const Text('Validate Form'),
                ),
                const SizedBox(height: 24),
                // Display current state of the data model live
                Consumer<FormData>(
                  builder: (context, formData, child) {
                    return Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Current Form Data:', style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 8),
                            Text('First Name: ${formData.firstName}'),
                            Text('Last Name: ${formData.lastName}'),
                            Text('Email: ${formData.email}'),
                            Text('Phone Number: ${formData.phoneNumber}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}