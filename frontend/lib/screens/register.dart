import 'package:flutter/material.dart';
import 'package:frontend/screens/login.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() {
    return _Register();
  }
}

// localhost/api/login
class _Register extends State<Register> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // bool isGmailAddress(String email) {
  //   final RegExp gmailRegex = RegExp(
  //     r'^[a-zA-Z0-9._-]+@.\$',
  //   );
  //   return gmailRegex.hasMatch(email);
  // }

  void _registerUser(BuildContext context) async {
    // final invalidEmail = isGmailAddress(_emailController.text);

    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Invalid Input"),
            content: const Text(
                "Please make sure you input data name,email,password correctly!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Okay"),
              )
            ],
          ),
        );
      }
    } else {
      final url = Uri.parse('http://10.0.2.2/api/register');
      Map<String, String> data = {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      try {
        final response = await http.post(
          url,
          body: json.encode(data),
          headers: {
            'Content-Type':
                'application/json', // Tentukan tipe konten sebagai JSON
          },
        );
        if (!context.mounted) {
          return;
        }
        if (response.statusCode == 200) {
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Register Success"),
                content: const Text("User account have been registered!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Okay"),
                  )
                ],
              ),
            );
          }
        } else {
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Register Failed"),
                content: Text(response.body),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Okay"),
                  )
                ],
              ),
            );
          }
        }
      } catch (err) {
        // print('Error during registration: $err');
      }
    }
  }

  void _toLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 100, 20, keyboard + 30),
            // padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            padding: EdgeInsets.fromLTRB(40, 40, 40, keyboard + 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color.fromARGB(73, 0, 0, 0),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Register',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold),
                ),
                TextField(
                  maxLength: 20,
                  decoration: InputDecoration(
                    label: Text(
                      "Name",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                  controller: _nameController,
                ),
                TextField(
                  maxLength: 20,
                  decoration: InputDecoration(
                    label: Text(
                      "Email",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                  controller: _emailController,
                ),
                TextField(
                  maxLength: 20,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text(
                      "Password",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () => _registerUser(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ), // Panjang dan tinggi sesuai kebutuhan
                  ),
                  child: Text(
                    "Register",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: _toLoginPage,
                      child: const Text('Sign In'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
