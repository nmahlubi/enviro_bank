import 'dart:convert';

List<Loan> usersModelFromJson(String str) =>
    List<Loan>.from(json.decode(str).map((x) => Loan.fromJson(x)));

String userModelToJson(List<Loan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Loan {
  late var amount;
  late var accountNumber;
  late String bankName;
  late var branchCode;
  late String collectionDate;
  late String firstName;
  late var idNumber;
  late String lastName;

  Loan(
      {required this.firstName,
      required this.accountNumber,
      required this.amount,
      required this.bankName,
      required this.branchCode,
      required this.collectionDate,
      required this.idNumber,
      required this.lastName});

  factory Loan.fromJson(Map<String, dynamic> parsedJson) {
    return Loan(
      firstName: parsedJson['firstName'] ?? "",
      accountNumber: parsedJson['accountNumber'] ?? "",
      amount: parsedJson['amount'] ?? "",
      bankName: parsedJson['bankName'] ?? "",
      branchCode: parsedJson['branchCode'] ?? "",
      collectionDate: parsedJson['collectionDate'] ?? "",
      idNumber: parsedJson['idNumber'] ?? "",
      lastName: parsedJson['lastName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['accountNumber'] = accountNumber;
    data['amount'] = amount;
    data['bankName'] = bankName;
    data['branchCode'] = branchCode;
    data['accountNumber'] = accountNumber;
    data['collectionDate'] = collectionDate;
    data['lastName'] = lastName;
    return data;
  }
}
