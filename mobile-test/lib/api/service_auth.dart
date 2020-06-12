import 'dart:convert';

import 'package:http/http.dart' as http;
// INTERNAL
import 'package:rca/api/constants.dart';
import 'package:rca/models/user.dart';

class AuthService {
  Future<http.Response> signIn(UserSignIn user) async {
    String _body = json.encode(user.value());
    String url = '$BASE_URL/auth/user/jwt';

    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: _body,
    );

    if (response.statusCode >= 400) {
      var body = json.decode(response.body);
      throw Exception(body);
    }

    return response;
  }

  Future<http.Response> checkToken(String accessToken) async {
    String url = '$BASE_URL/auth/user/jwt/check';

    http.Response response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $accessToken'
      },
    );

    if (response.statusCode >= 400) {
      var body = json.decode(response.body);
      throw Exception(body);
    }

    return response;
  }

  /*
    //As the service was giving 400

    Future<dynamic> checkIsActive() async {
    Auth auth = new Auth();
    var token = auth.accessToken;

    String url = '$BASE_URL/group/$GROUP_ID/activity/isActive';

    http.Response response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      print(jsondata);
    } else {
      return null;
    }
  }
   */
  Future<bool> checkIsActive() async {
    Random random = new Random();
    return random.nextBool();
  }

  dispose() {}
}
