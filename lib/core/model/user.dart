import 'dart:convert';

List<User> usersModelFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userModelToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  late String emailAddress;
  late String password;

  User({
    required this.emailAddress,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      emailAddress: parsedJson['emailAddress'] ?? "",
      password: parsedJson['password'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emailAddress'] = emailAddress;
    data['password'] = password;

    return data;
  }
}
