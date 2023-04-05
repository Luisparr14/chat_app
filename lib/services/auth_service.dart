import 'dart:convert';

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  late User user;
  bool authenticating = false;

  bool get getAuthenticating => authenticating;

  set setAuthenticating(bool value) {
    authenticating = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    setAuthenticating = true;
    final data = {'email': email, 'password': password};
    final res = await http.post(
        Uri.parse('${Enviroment.apiBaseUrl()}/auth/login'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});
    setAuthenticating = false;

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.user;
      return true;
    }

    return false;
  }
}
