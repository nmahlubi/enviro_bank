import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../ui/widgets/progress.indicator.widget.dart';
import '../const/headers.dart';
import '../model/user.dart';

class UserService {
  final String apiUrl =
      "http://ec2-63-33-169-221.eu-west-1.compute.amazonaws.com/loans-api/users";

  Future<User> registerUser(User user) async {
    Map data = {
      'emailAddress': user.emailAddress,
      'password': user.password,
    };
    final Response response = await post(
      Uri.parse(apiUrl),
      headers: AppHeaders.unAuthenticatedHeaders(),
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<http.Response?> loginUser(
      String emailAddress, String password, BuildContext context) async {
    try {
      showLoaderDialog(context: context, loadingMessage: "Trying to login...");
      final body = jsonEncode({
        'emailAddress': emailAddress,
        'password': password,
      });

      final response = await http.post(Uri.parse('$apiUrl/login'),
          body: body, headers: AppHeaders.unAuthenticatedHeaders());

      return response;
    } catch (e) {
      return null;
    } finally {
      Navigator.pop(
          context); //Always include this when you've called  showLoaderDialog widget
    }
  }
}
