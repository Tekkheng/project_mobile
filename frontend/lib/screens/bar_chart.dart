import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/data.dart';
import 'package:frontend/providers/data.dart';
import 'package:frontend/screens/confusion_matrix.dart';
import 'package:frontend/screens/confusion_matrix_multiclass.dart';
import 'package:frontend/screens/dashboard.dart';
import 'package:frontend/screens/dataset.dart';
import 'package:frontend/screens/manage_users.dart';
import 'package:frontend/screens/pie_chart.dart';
import 'package:frontend/widgets/drawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartScreen extends ConsumerStatefulWidget {
  const BarChartScreen({super.key});

  @override
  ConsumerState<BarChartScreen> createState() {
    return _BarChartScreen();
  }
}

class _BarChartScreen extends ConsumerState<BarChartScreen> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    ref.read(dataProvider.notifier).getData();

    super.initState();
  }

  List<GDPData> getChartData(List<DataModel> data) {
    final positifLength =
        data.where((d) => d.label == "Positif").toList().length;
    final negatifLength =
        data.where((d) => d.label == "Negatif").toList().length;
    final netralLength = data.where((d) => d.label == "Netral").toList().length;

    final List<GDPData> chartData = [
      GDPData('Positive', positifLength),
      GDPData('Negative', negatifLength),
      GDPData('Netral', netralLength),
    ];
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(dataProvider);
    _chartData = getChartData(data);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar Chart Page"),
      ),
      body: SafeArea(
        child: SfCartesianChart(
          title: const ChartTitle(text: 'Presentase Sentimen Bar Chart'),
          legend: const Legend(
              isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          tooltipBehavior: _tooltipBehavior,
          series: <CartesianSeries>[
            ColumnSeries<GDPData, String>(
              dataSource: _chartData,
              xValueMapper: (GDPData data, _) => data.continent,
              yValueMapper: (GDPData data, _) => data.gdp,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              enableTooltip: true,
              pointColorMapper: (GDPData data, _) {
                switch (data.continent) {
                  case 'Positive':
                    return Colors.green; // Warna untuk kategori Positif
                  case 'Negative':
                    return Colors.red; // Warna untuk kategori Negatif
                  case 'Netral':
                    return Colors.blue; // Warna untuk kategori Netral
                  default:
                    return Colors
                        .grey; // Warna default jika tidak ada kategori yang sesuai
                }
              },
            ),
          ],
          primaryXAxis: const CategoryAxis(),
          primaryYAxis: const NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(text: 'Count'),
          ),
        ),
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
    );
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
