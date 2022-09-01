import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class AppHeaders {
//Use these headers if you don't need to login
  static unAuthenticatedHeaders() {
    return {'Content-type': 'application/json', 'Accept': 'application/json'};
  }

//Use these headers after you've logged in
  static authenticatedHeaders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _token = pref
        .getString(Constants.USER_TOKEN); //TOKEN that was set on user login.
    return {
      'Content-Type': 'charset=UTF-8',
      'Content-type': 'application/json',
      'authorization': '$_token'
    };
  }
}
