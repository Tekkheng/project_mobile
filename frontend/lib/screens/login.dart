import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/user.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/screens/dashboard.dart';
import 'package:frontend/screens/register.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() {
    return _Login();
  }
}

class _Login extends ConsumerState<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginUser(BuildContext context) async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please make sure you input data email,password correctly!"),
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
    } else {
      final url = Uri.parse('http://10.0.2.2/api/login');
      Map<String, String> data = {
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
        final responseBody = json.decode(response.body);
        if (response.statusCode == 200 && responseBody['success']) {
          final id = responseBody['data']['id'];
          final name = responseBody['data']['name'];
          final email = responseBody['data']['email'];

          ref.read(userFilterProvider.notifier).addUser(
                UserModel(id: id, name: name, email: email),
              );
          // ref.read(userFilterProvider.notifier).getUserFilter(UserModel(id: id, name: name, email: email));

          if (!context.mounted) {
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const DashBoard(),
            ),
          );
        } else {
          if (!context.mounted) {
            return;
          }
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Login Failed"),
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
      } catch (err) {
        // print('failed login: $err');
      }
    }
  }

  void _toRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const Register(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromARGB(73, 0, 0, 0),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    maxLength: 20,
                    keyboardType: TextInputType.emailAddress,
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
                    onPressed: () => _loginUser(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(
                        double.infinity,
                        50,
                      ), // Panjang dan tinggi sesuai kebutuhan
                    ),
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\t have an account?'),
                      TextButton(
                        onPressed: _toRegisterPage,
                        child: const Text('Sign Up'),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
