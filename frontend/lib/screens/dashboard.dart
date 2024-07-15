import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/user.dart';
import 'package:frontend/screens/bar_chart.dart';
import 'package:frontend/screens/dataset.dart';
import 'package:frontend/screens/manage_users.dart';
import 'package:frontend/screens/pie_chart.dart';
import 'package:frontend/widgets/drawer.dart';

class DashBoard extends ConsumerWidget {
  const DashBoard({super.key});

  void _changeScreen(String identifier, BuildContext context) {
    Navigator.pop(context);
    if (identifier == "dataset") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const DataSetScreen(),
        ),
      );
    } else if (identifier == "manage_users") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const ManageUsers(),
        ),
      );
    } else if (identifier == "piechart") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const PieChartScreen(),
        ),
      );
    } else if (identifier == "barchart") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const BarChartScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLogin = ref.watch(userFilterProvider);
    final name = userLogin['user']!.name;
    // final name = userLogin.map((e) => e.id);
    // print(userLogin);

    return Scaffold(
      appBar: AppBar(
        title: const Text("DashBoard Page"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      drawer: MainDrawer(changeScreen: _changeScreen),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to DashBoard $name!'),
          ],
        ),
      ),
    );
  }
}
