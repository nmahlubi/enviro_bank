import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/model/loan.dart';
import '../../../../core/model/user.dart';
import '../../../../core/service/loan.service.dart';
import '../../../../core/service/user.service.dart';
import '../../../components/page.title.bar.dart';
import '../../../components/under.part.dart';
import '../../../components/upside.dart';
import '../../../shared/shared.dart';
import '../../../widgets/rounded.button.dart';
import '../../../widgets/textfield.container.widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController amount = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController branchCode = TextEditingController();
  TextEditingController collectionDate = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  TextEditingController lastName = TextEditingController();

  TextEditingController dateInput = TextEditingController();

  final LoanService api = LoanService();
  final gnd = [
    "ABSA",
    "FNB",
    "INVESTEC LIMITED",
    "NEDBANK LIMITED",
    "STANDARD BANK",
    "VBS",
  ];
  // TextEditingController value = TextEditingController();
  String? value;

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    // value as TextEditingController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DropdownMenuItem<String> buildMenuItem(String item) =>
        DropdownMenuItem(value: item, child: Text(item));

    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  const Upside(
                    imgUrl: "assets/images/register.png",
                  ),
                  const PageTitleBar(title: 'Apply for a Loan'),
                  Padding(
                    padding: const EdgeInsets.only(top: 320.0),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          // iconButton(context),
                          const SizedBox(
                            height: 20,
                          ),
                          // const Text(
                          //   "or use your email account",
                          //   style: TextStyle(
                          //       color: Colors.grey,
                          //       fontFamily: 'OpenSans',
                          //       fontSize: 13,
                          //       fontWeight: FontWeight.w600),
                          // ),
                          Form(
                            child: Column(
                              children: [
                                TextFieldContainer(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Amount is empty';
                                      }
                                      return null;
                                    },
                                    controller: amount,
                                    cursorColor: kPrimaryColor,
                                    decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.mail,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'Amount',
                                        hintStyle:
                                            TextStyle(fontFamily: 'OpenSans'),
                                        border: InputBorder.none),
                                  ),
                                ),
                                // const RoundedInputField(
                                //     hintText: "Name", icon: Icons.person),
                                TextFieldContainer(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Account Number is empty';
                                      }
                                      return null;
                                    },
                                    controller: accountNumber,
                                    cursorColor: kPrimaryColor,
                                    decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.lock,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'Account Number',
                                        hintStyle:
                                            TextStyle(fontFamily: 'OpenSans'),
                                        border: InputBorder.none),
                                  ),
                                ),
                                TextFieldContainer(
                                  child: DropdownButton<String>(
                                    // icon: Icon(Icons.location_city),
                                    hint: const Text("Select Bank"),
                                    value: value,
                                    isExpanded: true,
                                    items: gnd.map(buildMenuItem).toList(),
                                    onChanged: (value) =>
                                        setState(() => this.value = value),
                                  ),
                                ),
                                TextFieldContainer(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Branch Code is empty';
                                      }
                                      return null;
                                    },
                                    controller: branchCode,
                                    cursorColor: kPrimaryColor,
                                    decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.lock,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'Branch Code',
                                        hintStyle:
                                            TextStyle(fontFamily: 'OpenSans'),
                                        border: InputBorder.none),
                                  ),
                                ),
                                TextFieldContainer(
                                  child: TextField(
                                    keyboardType: TextInputType.datetime,
                                    controller: dateInput,
                                    //editing controller of this TextField
                                    decoration: InputDecoration(
                                        // icon: Icon(Icons.calendar_today
                                        // ), //icon of text field
                                        labelText:
                                            "Enter date of birth" //label text of field
                                        ),
                                    readOnly: true,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2100));

                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        setState(() {
                                          dateInput.text =
                                              formattedDate; //set output date to TextField value.
                                        });
                                      } else {}
                                    },
                                  ),
                                ),
                                TextFieldContainer(
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'First Name is empty';
                                      }
                                      return null;
                                    },
                                    controller: firstName,
                                    cursorColor: kPrimaryColor,
                                    decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.lock,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'First Name',
                                        hintStyle:
                                            TextStyle(fontFamily: 'OpenSans'),
                                        border: InputBorder.none),
                                  ),
                                ),
                                TextFieldContainer(
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Last Name is empty';
                                      }
                                      return null;
                                    },
                                    controller: lastName,
                                    cursorColor: kPrimaryColor,
                                    decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.lock,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'Last Name',
                                        hintStyle:
                                            TextStyle(fontFamily: 'OpenSans'),
                                        border: InputBorder.none),
                                  ),
                                ),
                                TextFieldContainer(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ID Number is empty';
                                      }
                                      return null;
                                    },
                                    maxLength: 13,
                                    controller: idNumber,
                                    cursorColor: kPrimaryColor,
                                    decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.lock,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'ID Number',
                                        hintStyle:
                                            TextStyle(fontFamily: 'OpenSans'),
                                        border: InputBorder.none),
                                  ),
                                ),
                                RoundedButton(
                                    text: 'SUBMIT',
                                    press: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        // api.createCase(Cases(name: _nameController.text, gender: gender, age: int.parse(_ageController.text), address: _addressController.text, city: _cityController.text, country: _countryController.text, status: status));
                                        api.createLoan(
                                          Loan(
                                              accountNumber:
                                                  int.parse(accountNumber.text),
                                              amount: int.parse(amount.text),
                                              bankName: value.toString(),
                                              branchCode:
                                                  int.parse(branchCode.text),
                                              collectionDate: dateInput.text,
                                              firstName: firstName.text,
                                              idNumber:
                                                  int.parse(idNumber.text),
                                              lastName: lastName.text),
                                        );
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen()));
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                // UnderPart(
                                //   title: "Already have an account?",
                                //   navigatorText: "Login here",
                                //   onTap: () {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) => Container()));
                                //   },
                                // ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
