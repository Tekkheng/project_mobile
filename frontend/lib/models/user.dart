// class UserModel {
//   const UserModel({required this.name, required this.email});
//   final String name, email;
// }

class UserModel {
  const UserModel({required this.id, required this.name, required this.email});
  final String name, email;
  final int id;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
