import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();

  final _inputController = TextEditingController();

  void _submitForm() {
    setState(() {
      _inputController.text = 'Sample Text';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            controller: _inputController,
            decoration: const InputDecoration(labelText: 'Enter a value'),
            keyboardType: TextInputType.none,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a value';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Input Text'),
          ),
        ]),
      ),
    );
  }
}
