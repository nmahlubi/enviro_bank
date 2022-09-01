import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../ui/widgets/progress.indicator.widget.dart';
import '../const/headers.dart';
import '../model/loan.dart';


class LoanService {
  final String apiUrl =
      "http://ec2-63-33-169-221.eu-west-1.compute.amazonaws.com/loans-api/loans";

  Future<Loan> createLoan(Loan loan) async {
    Map data = {
      'lastName': loan.lastName,
      'firstName': loan.firstName,
      'idNumber': loan.idNumber,
      'collectionDate': loan.collectionDate,
      'branchCode': loan.branchCode,
      'bankName': loan.bankName,
      'amount': loan.amount,
      'accountNumber': loan.accountNumber,
    };
    final Response response = await post(
      Uri.parse(apiUrl),
      headers: AppHeaders.authenticatedHeaders(),
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Loan.fromJson(json.decode(response.body));
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
// }
}
