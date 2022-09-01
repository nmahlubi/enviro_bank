
import 'package:enviro_bank/ui/screens/auth/screen/login.screen.dart';
import 'package:enviro_bank/ui/screens/auth/screen/signup.screen.dart';
import 'package:enviro_bank/ui/screens/home/screen/home.screen.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signupScreen':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/homeScreen':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => Container());
      case '/homeE':
        return MaterialPageRoute(builder: (_) => Container());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No Route defines for ${settings.name}'),
                  ),
                ));
    }
  }
}
