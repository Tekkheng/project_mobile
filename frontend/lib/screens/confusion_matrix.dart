import 'package:flutter/material.dart';
import 'package:frontend/models/accuracy.dart';
import 'package:frontend/screens/bar_chart.dart';
import 'package:frontend/screens/confusion_matrix_multiclass.dart';
import 'package:frontend/screens/dashboard.dart';
import 'package:frontend/screens/dataset.dart';
import 'package:frontend/screens/manage_users.dart';
import 'package:frontend/screens/pie_chart.dart';
import 'package:frontend/widgets/drawer.dart';

class ConfusionMatrix extends StatefulWidget {
  const ConfusionMatrix({super.key});

  @override
  State<ConfusionMatrix> createState() => _ConfusionMatrixState();
}

class _ConfusionMatrixState extends State<ConfusionMatrix> {
  @override
  Widget build(BuildContext context) {
    const data = [
      AccuracyModel(
        type: 'KKN',
        accuracy: 83.75,
        mae: 52.10,
        mse: 290.12,
        rmse: 170.33,
      ),
      AccuracyModel(
        type: 'K-Means',
        accuracy: 83.75,
        mae: 52.10,
        mse: 290.12,
        rmse: 170.33,
      ),
      //
      AccuracyModel(
        type: 'LSTM',
        accuracy: 85,
        mae: 20,
        mse: 30,
        rmse: 55,
      )
    ];
    Widget content = data.isEmpty
        ? const Center(
            child: Text('Data Accuracy masih Kosong!'),
          )
        : Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columnSpacing: 20,
                    horizontalMargin: 5,
                    columns: const [
                      DataColumn(label: Text('Method')),
                      DataColumn(label: Text('Accuracy')),
                      DataColumn(label: Text('MAE')),
                      DataColumn(label: Text('MSE')),
                      DataColumn(label: Text('RMSE')),
                    ],
                    rows: data.asMap().entries.map((entry) {
                      final dataSet = entry.value;
                      return DataRow(cells: [
                        DataCell(Text(dataSet.type)),
                        DataCell(
                            Text("${dataSet.accuracy!.toStringAsFixed(2)}%")),
                        DataCell(Text("${dataSet.mae!.toStringAsFixed(2)}%")),
                        DataCell(Text("${dataSet.mse!.toStringAsFixed(2)}%")),
                        DataCell(Text("${dataSet.rmse!.toStringAsFixed(2)}%")),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Confusion Matrix Page"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ],
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
            } else if (identifier == "dataset") {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const DataSetScreen(),
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
        body: content);
  }
}
