import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../../../../core/const/constants.dart';
import '../../../../core/const/shared.pref.dart';
import '../../../../core/model/user.dart';
import '../../../../core/service/user.service.dart';
import '../../../components/page.title.bar.dart';
import '../../../components/under.part.dart';
import '../../../components/upside.dart';
import '../../../shared/shared.dart';
import '../../../widgets/rounded.button.dart';
import '../../../widgets/rounded.input.field.widget.dart';
import '../../../widgets/rounded.password.widget.dart';
import '../../../widgets/snackbar.widget.dart';
import '../../../widgets/textfield.container.widget.dart';
import 'login.screen.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  final UserService api = UserService();

  bool success = false;

  @override
  Widget build(BuildContext context) {
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
                  const PageTitleBar(title: 'Create New Account'),
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Email is empty';
                                      }
                                      return null;
                                    },
                                    controller: emailAddress,
                                    cursorColor: kPrimaryColor,
                                    decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.mail,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'email',
                                        hintStyle:
                                            TextStyle(fontFamily: 'OpenSans'),
                                        border: InputBorder.none),
                                  ),
                                ),
                                // const RoundedInputField(
                                //     hintText: "Name", icon: Icons.person),
                                TextFieldContainer(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Password is empty';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    controller: password,
                                    cursorColor: kPrimaryColor,
                                    decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.lock,
                                          color: kPrimaryColor,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.visibility,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'Password',
                                        hintStyle:
                                            TextStyle(fontFamily: 'OpenSans'),
                                        border: InputBorder.none),
                                  ),
                                ),
                                FlutterPwValidator(
                                  controller: password,
                                  minLength: 8,
                                  uppercaseCharCount: 1,
                                  numericCharCount: 1,
                                  specialCharCount: 1,
                                  normalCharCount: 3,
                                  width: 400,
                                  height: 150,
                                  onSuccess: () {
                                    setState(() {
                                      success = true;
                                    });
                                    print("MATCHED");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Password is matched")));
                                  },
                                  onFail: () {
                                    setState(() {
                                      success = false;
                                    });
                                    print("NOT MATCHED");
                                  },
                                ),
                                RoundedButton(
                                    text: 'REGISTER',
                                    press: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        // api.createCase(Cases(name: _nameController.text, gender: gender, age: int.parse(_ageController.text), address: _addressController.text, city: _cityController.text, country: _countryController.text, status: status));
                                        api.registerUser(
                                          User(
                                              emailAddress: emailAddress.text,
                                              password: password.text),
                                        );
                                        Navigator.pop(context);
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                UnderPart(
                                  title: "Already have an account?",
                                  navigatorText: "Login here",
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  },
                                ),
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
