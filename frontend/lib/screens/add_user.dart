import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  const AddUser({super.key});
  @override
  State<AddUser> createState() => _AddUser();
}

class _AddUser extends State<AddUser> {
  final formKey = GlobalKey<FormState>();
  String _enteredName = "";
  String _enteredEmail = "";
  String _enteredPassword = "";

  void _submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final url = Uri.parse('');
      final Map<String, dynamic> data = {
        'name': _enteredName,
        'email': _enteredEmail,
        'password': _enteredPassword
      };

      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data),
        );
        if (!context.mounted) {
          return;
        }
        if (response.statusCode == 200) {
          formKey.currentState!.reset();
          Navigator.pop(context);
        }
      } catch (err) {
        // print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                maxLength: 30,
                decoration: const InputDecoration(
                  label: Text('name'),
                ),
                onSaved: (value) {
                  setState(() {
                    _enteredName = value!;
                  });
                },
                validator: (value) {
                  if (value!.trim().length <= 1 ||
                      value.trim().length > 50 ||
                      value.isEmpty) {
                    return 'name character must be betwen 1 and 30!';
                  }
                  return null;
                },
              ),
              TextFormField(
                maxLength: 40,
                decoration: const InputDecoration(
                  label: Text('email'),
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  setState(() {
                    _enteredEmail = value!;
                  });
                },
                validator: (value) {
                  if (value!.trim().length <= 4 ||
                      value.trim().length > 30 ||
                      value.isEmpty) {
                    return 'email character must be betwen 4 and 30!';
                  }
                  return null;
                },
              ),
              TextFormField(
                maxLength: 30,
                decoration: const InputDecoration(
                  label: Text('password'),
                ),
                obscureText: true,
                onSaved: (value) {
                  setState(() {
                    _enteredPassword = value!;
                  });
                },
                validator: (value) {
                  if (value!.trim().length <= 4 ||
                      value.trim().length > 30 ||
                      value.isEmpty) {
                    return 'password character must be betwen 4 and 30!';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                        foregroundColor:
                            Theme.of(context).colorScheme.primaryContainer),
                    child: const Text('Submit'),
                  ),
                  TextButton(
                    onPressed: () => formKey.currentState!.reset(),
                    style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                        foregroundColor:
                            Theme.of(context).colorScheme.primaryContainer),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
