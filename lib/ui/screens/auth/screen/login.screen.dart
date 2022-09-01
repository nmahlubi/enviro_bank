import 'dart:convert';
import 'package:enviro_bank/ui/screens/auth/screen/signup.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/const/constants.dart';
import '../../../../core/const/shared.pref.dart';
import '../../../../core/service/user.service.dart';
import '../../../components/page.title.bar.dart';
import '../../../components/under.part.dart';
import '../../../components/upside.dart';
import '../../../shared/shared.dart';
import '../../../widgets/rounded.button.dart';
import '../../../widgets/rounded.icon.eidget.dart';
import '../../../widgets/snackbar.widget.dart';
import '../../../widgets/textfield.container.widget.dart';
import 'package:http/http.dart' as http;

import '../../home/screen/home.screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  final UserService api = UserService();

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
                    imgUrl: "assets/images/login.png",
                  ),
                  const PageTitleBar(title: 'Login to your account'),
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
                                //     hintText: "Email", icon: Icons.email),
                                TextFieldContainer(
                                  child: TextFormField(
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
                                // switchListTile(),
                                RoundedButton(
                                    text: 'LOGIN',
                                    press: () async {
                                      if (emailAddress.text == "" ||
                                          password.text == "") {
                                        showSnackBar(
                                            context: context,
                                            message:
                                                "Enter Your email & password!!!",
                                            color: Colors.red);
                                      } else {
                                        http.Response? res = await UserService()
                                            .loginUser(emailAddress.text,
                                                password.text, context);

                                        if (res == null) {
                                          showSnackBar(
                                              context: context,
                                              message: "Error occurred!!!",
                                              color: Colors.red);
                                        } else {
                                          var jwt = jsonDecode(res.body);
                                          print(jwt);
                                          if (res.statusCode != 200) {
                                            showSnackBar(
                                                context: context,
                                                message:
                                                    'Please contact service',
                                                color: Colors.red);
                                          } else {
                                            // SharedPreferences pref =
                                            // await SharedPreferences
                                            //     .getInstance();
                                            // pref.setString(Constants.USER_TOKEN,
                                            //     results['results']);
                                            print(jwt['jwt']);
                                            await AppCache.set(
                                                Constants.USER_TOKEN,
                                                jwt['jwt']);

                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen()));
                                          }
                                        }
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                UnderPart(
                                  title: "Don't have an account?",
                                  navigatorText: "Register here",
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpScreen()));
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 20,
                                )
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

switchListTile() {
  return Padding(
    padding: const EdgeInsets.only(left: 50, right: 40),
    child: SwitchListTile(
      dense: true,
      title: const Text(
        'Remember Me',
        style: TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
      ),
      value: true,
      activeColor: kPrimaryColor,
      onChanged: (val) {},
    ),
  );
}

iconButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      RoundedIcon(imageUrl: "assets/images/facebook.png"),
      SizedBox(
        width: 20,
      ),
      RoundedIcon(imageUrl: "assets/images/twitter.png"),
      SizedBox(
        width: 20,
      ),
      RoundedIcon(imageUrl: "assets/images/google.jpg"),
    ],
  );
}
