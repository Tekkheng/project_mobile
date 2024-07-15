import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/data.dart';
import 'package:frontend/screens/bar_chart.dart';
import 'package:frontend/screens/dashboard.dart';
import 'package:frontend/screens/manage_users.dart';
import 'package:frontend/screens/pie_chart.dart';
import 'package:frontend/widgets/drawer.dart';

class DataSetScreen extends ConsumerStatefulWidget {
  const DataSetScreen({super.key});

  @override
  ConsumerState<DataSetScreen> createState() => _DataSetScreenState();
}

class _DataSetScreenState extends ConsumerState<DataSetScreen> {
  @override
  void initState() {
    ref.read(dataProvider.notifier).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final data = ref.watch(dataProvider);
    final data = ref.watch(dataProvider.select((value) => value.sublist(0, 500))); // Mengambil 10 data pertama

    // print(data);

    Widget content = data.isEmpty
        ? const Center(
            child: Text('Dataset masih Kosong!'),
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
                    horizontalMargin: 30,
                    columns: const [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('ID Str')),
                      DataColumn(label: Text('Clean Text')),
                      DataColumn(label: Text('Quote Count')),
                      DataColumn(label: Text('Reply Count')),
                      DataColumn(label: Text('Retweet Count')),
                      DataColumn(label: Text('Favorite Count')),
                      DataColumn(label: Text('Lang')),
                      DataColumn(label: Text('User Id Str')),
                      DataColumn(label: Text('Conversation Id Str')),
                      DataColumn(label: Text('Username')),
                      DataColumn(label: Text('Tweet Url')),
                      DataColumn(label: Text('Label')),
                      DataColumn(label: Text('Created At')),
                    ],
                    rows: data.asMap().entries.map((entry) {
                      final index = entry.key + 1;
                      final dataSet = entry.value;
                      return DataRow(cells: [
                        DataCell(Text('$index')),
                        DataCell(Text(dataSet.idStr.toString())),
                        DataCell(Text(dataSet.cleanTxt)),
                        DataCell(Text(dataSet.quoteCount.toString())),
                        DataCell(Text(dataSet.replyCount.toString())),
                        DataCell(Text(dataSet.retweetCount.toString())),
                        DataCell(Text(dataSet.favCount.toString())),
                        DataCell(Text(dataSet.lang)),
                        DataCell(Text(dataSet.userIdStr.toString())),
                        DataCell(Text(dataSet.conversationIdStr.toString())),
                        DataCell(Text(dataSet.username)),
                        DataCell(Text(dataSet.tweetUrl)),
                        DataCell(Text(dataSet.label)),
                        DataCell(Text(dataSet.createdAt)),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          );

    return Scaffold(
        appBar: AppBar(
          title: const Text("DataSet Page"),
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
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        body: content);
  }
}
