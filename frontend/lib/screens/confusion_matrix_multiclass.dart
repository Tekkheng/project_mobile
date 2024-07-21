import 'package:flutter/material.dart';
import 'package:frontend/models/accuracy.dart';
import 'package:frontend/screens/bar_chart.dart';
import 'package:frontend/screens/confusion_matrix.dart';
import 'package:frontend/screens/dashboard.dart';
import 'package:frontend/screens/dataset.dart';
import 'package:frontend/screens/manage_users.dart';
import 'package:frontend/screens/pie_chart.dart';
import 'package:frontend/widgets/drawer.dart';

class ConfusionMatrixMulticlass extends StatefulWidget {
  const ConfusionMatrixMulticlass({super.key});

  @override
  State<ConfusionMatrixMulticlass> createState() =>
      _ConfusionMatrixMulticlassState();
}

class _ConfusionMatrixMulticlassState extends State<ConfusionMatrixMulticlass> {
  @override
  Widget build(BuildContext context) {
    const data = [
      AccuracyModel(
        type: 'KKN Positif',
        presisi: 0,
        recall: 0,
        f1Score: 0,
      ),
      AccuracyModel(
        type: 'KKN Negatif',
        presisi: 84,
        recall: 100,
        f1Score: 91,
      ),
      AccuracyModel(
        type: 'KKN Netral',
        presisi: 0,
        recall: 0,
        f1Score: 0,
      ),
      AccuracyModel(
        type: 'K-Means Positif',
        presisi: 100,
        recall: 0,
        f1Score: 0,
      ),
      AccuracyModel(
        type: 'K-Means Negatif',
        presisi: 84,
        recall: 100,
        f1Score: 91,
      ),
      AccuracyModel(
        type: 'K-Means Netral',
        presisi: 0,
        recall: 0,
        f1Score: 0,
      ),
      AccuracyModel(
        type: 'LSTM Positif',
        presisi: 100,
        recall: 83,
        f1Score: 91,
      ),
      AccuracyModel(
        type: 'LSTM Negatif',
        presisi: 88,
        recall: 88,
        f1Score: 88,
      ),
      AccuracyModel(
        type: 'LSTM Netral',
        presisi: 71,
        recall: 83,
        f1Score: 77,
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
                    columnSpacing: 25,
                    horizontalMargin: 25,
                    columns: const [
                      DataColumn(label: Text('Method')),
                      DataColumn(label: Text('Presisi')),
                      DataColumn(label: Text('Recall')),
                      DataColumn(label: Text('F1 Score')),
                    ],
                    rows: data.asMap().entries.map((entry) {
                      final dataSet = entry.value;
                      return DataRow(cells: [
                        DataCell(Text(dataSet.type)),
                        DataCell(
                            Text("${dataSet.presisi!.toStringAsFixed(2)}%")),
                        DataCell(Text("${dataSet.recall!.toStringAsFixed(2)}%")),
                        DataCell(
                            Text("${dataSet.f1Score!.toStringAsFixed(2)}%")),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Confusion Matrix MultiClass Page"),
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
            } else if (identifier == "confusion_matrix") {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const ConfusionMatrix(),
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
