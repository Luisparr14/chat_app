import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/user.dart';

class AuthService with ChangeNotifier {
  final storage = const FlutterSecureStorage();
  late User user;
  bool authenticating = false;

  bool get getAuthenticating => authenticating;

  set setAuthenticating(bool value) {
    authenticating = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
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
      _saveToken(loginResponse.token);
      return true;
    } else {
      logOut();
      return false;
    }
  }

  Future<dynamic> register(String name, String email, String password) async {
    final data = {'name': name, 'email': email, 'password': password};
    setAuthenticating = true;
    final res = await http.post(
        Uri.parse('${Enviroment.apiBaseUrl()}/auth/register'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});
    setAuthenticating = false;

    if (res.statusCode == 201) {
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.user;
      _saveToken(loginResponse.token);
      return true;
    }
    final resBody = jsonDecode(res.body);
    return resBody['message'];
  }

  void _saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'token');
    final res = await http.get(
        Uri.parse('${Enviroment.apiBaseUrl()}/auth/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token ?? ''});
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.user;
      return true;
    }
    return false;
  }

  void logOut() async {
    await storage.delete(key: 'token');
  }
}
