import 'dart:convert';

import 'package:chat_app/global/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  Future login(String email, String password) async {
    final data = {'email': email, 'password': password};

    final res = await http.post(
        Uri.parse('${Enviroment.apiBaseUrl()}/auth/login'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});

    print(res.body);
  }
}
