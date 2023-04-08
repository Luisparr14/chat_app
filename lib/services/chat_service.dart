import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/models/messages_response.dart';
import 'package:chat_app/models/user.dart';

class ChatService with ChangeNotifier {
  late User user;

  Future<List<Message>> getMessages(String userFrom) async {
    try {
      final res = await http.get(
          Uri.parse('${Enviroment.apiBaseUrl}/messages/$userFrom'),
          headers: <String, String>{
            "Content-Type": "application/json",
            "x-token": await AuthService.getToken() ?? ''
          });

      final messagesResponse = messagesResponseFromJson(res.body);

      return messagesResponse.messages;
    } catch (error) {
      return [];
    }
  }
}
