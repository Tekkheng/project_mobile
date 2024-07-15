import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/data.dart';
import 'package:http/http.dart' as http;

class DataNotifier extends StateNotifier<List<DataModel>> {
  DataNotifier() : super([]);

  void getData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2/api/dataset'));
    // print('API Response: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final List<DataModel> data =
          jsonData.map((data) => DataModel.fromJson(data)).toList();

      state = data;

      // print('API Response: $state');
    } else {
      throw Exception('Failed to load data');
    }
  }
}

final dataProvider = StateNotifierProvider<DataNotifier, List<DataModel>>(
    (ref) => DataNotifier());
