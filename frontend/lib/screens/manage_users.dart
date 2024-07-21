import 'package:flutter/material.dart';
import 'package:frontend/providers/user.dart';
import 'package:frontend/screens/confusion_matrix.dart';
import 'package:frontend/screens/bar_chart.dart';
import 'package:frontend/screens/confusion_matrix_multiclass.dart';
import 'package:frontend/screens/dashboard.dart';
import 'package:frontend/screens/dataset.dart';
import 'package:frontend/screens/pie_chart.dart';
import 'package:frontend/widgets/drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageUsers extends ConsumerStatefulWidget {
  const ManageUsers({super.key});

  @override
  ConsumerState<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends ConsumerState<ManageUsers> {
  @override
  void initState() {
    ref.read(userProvider.notifier).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataUser = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("UserManage Page"),
      ),
      drawer: MainDrawer(
        changeScreen: (identifier, context) {
          if (identifier == "dashboard") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => const DashBoard(),
              ),
            );
          } else if (identifier == "dataset") {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const DataSetScreen(),
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
          } else if (identifier == "confusion_matrix") {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const ConfusionMatrix(),
              ),
            );
          } else if (identifier == "confusion_matrix_multiclass") {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const ConfusionMatrixMulticlass(),
              ),
            );
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 30,
            horizontalMargin: 20,
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('User Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Action')),
            ],
            rows: [
              ...dataUser.map(
                (user) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        user.id.toString(),
                      ),
                    ),
                    DataCell(
                      Text(user.name),
                    ),
                    DataCell(
                      Text(user.email),
                    ),
                    DataCell(
                      Wrap(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Edit'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
