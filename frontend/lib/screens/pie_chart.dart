import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/data.dart';
import 'package:frontend/providers/data.dart';
import 'package:frontend/screens/bar_chart.dart';
import 'package:frontend/screens/dashboard.dart';
import 'package:frontend/screens/dataset.dart';
import 'package:frontend/screens/manage_users.dart';
import 'package:frontend/widgets/drawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartScreen extends ConsumerStatefulWidget {
  const PieChartScreen({super.key});

  @override
  ConsumerState<PieChartScreen> createState() {
    return _PieChartScreen();
  }
}

class _PieChartScreen extends ConsumerState<PieChartScreen> {
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
    // print('akheng $positifLength');
    // print('akheng $negatifLength');
    // print('akheng $netralLength');

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
        title: const Text("Pie Chart Page"),
      ),
      body: SafeArea(
        child: SfCircularChart(
          title: const ChartTitle(text: 'Presentase Sentimen Pie Chart'),
          legend: const Legend(
              isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            PieSeries<GDPData, String>(
              dataSource: _chartData,
              xValueMapper: (GDPData data, _) => data.continent,
              yValueMapper: (GDPData data, _) => data.gdp,

              pointColorMapper: (GDPData data, _) {
                switch (data.continent) {
                  case 'Positive':
                    return Colors.green; // Custom color for 'Positive'
                  case 'Negative':
                    return Colors.red; // Custom color for 'Negative'
                  case 'Netral':
                    return Colors.blue; // Custom color for 'Netral'
                  default:
                    return Colors.grey;
                }
              },
              // PieSeries<DataModel, String>(
              //   dataSource: data, // Gunakan data dari provider
              //   xValueMapper: (DataModel data, _) => data.label,
              //   yValueMapper: (DataModel data, _) => data.label.length,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
              enableTooltip: true,
            ),
          ],
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
          } else if (identifier == "barchart") {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const BarChartScreen(),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:frontend/models/data.dart';
// import 'package:frontend/providers/data.dart';
// import 'package:frontend/screens/dashboard.dart';
// import 'package:frontend/screens/dataset.dart';
// import 'package:frontend/widgets/drawer.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class ReportsPage extends ConsumerStatefulWidget {
//   const ReportsPage({super.key});

//   @override
//   ConsumerState<ReportsPage> createState() {
//     return _ReportsPage();
//   }
// }

// class _ReportsPage extends ConsumerState<ReportsPage> {
//   late List<GDPData> _chartData;
//   late TooltipBehavior _tooltipBehavior;

//   @override
//   void initState() {
//     _chartData = getChartData();
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     ref.read(dataProvider.notifier).getData();

//     super.initState();
//   }

//   List<GDPData> getChartData() {
//     final List<GDPData> chartData = [
//       // GDPData('Present', 300),
//       // GDPData('Absent', 100),
//       // GDPData('Extras', 200),
//       // GDPData('Late', 50),
//       // GDPData('Oceania', 150),
//       // GDPData('Oceania', 150),

//       GDPData('Positive', 300),
//       GDPData('Negative', 100),
//       GDPData('Netral', 100),
//     ];
//     return chartData;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final data = ref.watch(dataProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Reports Page"),
//       ),
//       body: SafeArea(
//         child: SfCircularChart(
//           title: const ChartTitle(text: 'Employee Reports 2022 - 2023'),
//           legend: const Legend(
//               isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
//           tooltipBehavior: _tooltipBehavior,
//           series: <CircularSeries>[
//             PieSeries<GDPData, String>(
//               dataSource: _chartData,
//               xValueMapper: (GDPData data, _) => data.continent,
//               yValueMapper: (GDPData data, _) => data.gdp,

//               // PieSeries<DataModel, String>(
//               //   dataSource: data, // Gunakan data dari provider
//               //   xValueMapper: (DataModel data, _) => data.label,
//               //   yValueMapper: (DataModel data, _) => data.label.length,
//               //   dataLabelSettings: const DataLabelSettings(
//               //     isVisible: true,
//               //   ),
//               //   enableTooltip: true,
//             ),
//           ],
//         ),
//       ),
//       drawer: MainDrawer(
//         changeScreen: (identifier, context) {
//           if (identifier == "dashboard") {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (ctx) => const DashBoard(),
//               ),
//             );
//           } else if (identifier == "dataset") {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (ctx) => const DataSetScreen(),
//               ),
//             );
//           } else if (identifier == "chartset") {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (ctx) => const ReportsPage(),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class GDPData {
//   GDPData(this.continent, this.gdp);
//   final String continent;
//   final int gdp;
// }
