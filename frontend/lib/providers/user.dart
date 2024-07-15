import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/user.dart';
import 'package:http/http.dart' as http;

// class UserNotifier extends StateNotifier<Map<String, UserModel>> {
//   UserNotifier() : super({});

//   void addUser(UserModel newDat) {
//     state = {'user': newDat};
//   }
// }

// final userProvider =
//     StateNotifierProvider<UserNotifier, Map<String, UserModel>>(
//   (ref) => UserNotifier(),
// );

class UserNotifier extends StateNotifier<List<UserModel>> {
  UserNotifier() : super([]);

  Future<void> getUserData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2/api/user'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final List<UserModel> users =
          jsonData.map((product) => UserModel.fromJson(product)).toList();

      state = users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, List<UserModel>>(
    (ref) => UserNotifier());


// class UserFilterNotifier extends StateNotifier<List<UserModel>> {
//   UserFilterNotifier() : super([]);

//   void getUserFilter(UserModel user) {
//     state = [...state,user];
//     // state = state.where((d) => d.id == user.id).toList();
//   }
// }

// final userFilterProvider =
//     StateNotifierProvider<UserFilterNotifier, List<UserModel>>(
//         (ref) => UserFilterNotifier());



class UserFilterNotifier extends StateNotifier<Map<String, UserModel>> {
  UserFilterNotifier() : super({});

  void addUser(UserModel newDat) {
    state = {'user': newDat};
  }
}

final userFilterProvider =
    StateNotifierProvider<UserFilterNotifier, Map<String, UserModel>>(
  (ref) => UserFilterNotifier(),
);