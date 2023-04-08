import 'dart:math';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late ChatService chatService;
  late AuthService authService;
  late SocketService socketService;

  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;

  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    chatService = Provider.of<ChatService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);

    socketService.socket.on('personal-message', _listenMessage);
    _loadMessagesHistory(chatService.user.uid);
    super.initState();
  }

  void _loadMessagesHistory(String userFrom) async {
    try {
      final chatHistory = await chatService.getMessages(userFrom);
      final chats = chatHistory.map((chat) => ChatMessage(
          uid: chat.from,
          text: chat.message,
          animationController: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 0))
            ..forward()));

      _messages.insertAll(0, chats);
      setState(() {});
    } catch (error) {
      print(error);
    }
  }

  void _listenMessage(payload) {
    ChatMessage message = ChatMessage(
        uid: payload['from'],
        text: payload['message'],
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 200)));

    _messages.insert(0, message);
    message.animationController.forward();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = chatService.user;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 18,
              child: Text(user.name.substring(0, 2).toUpperCase()),
            ),
            const SizedBox(height: 2),
            Text(user.name, style: const TextStyle(fontSize: 12))
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              itemBuilder: (_, i) => _messages[i],
              itemCount: _messages.length,
              reverse: true,
            )),
            const Divider(height: 2),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                Flexible(
                    child: TextField(
                  onSubmitted: _isWriting ? _handleSubmit : null,
                  controller: _textController,
                  decoration:
                      const InputDecoration.collapsed(hintText: 'Send message'),
                  focusNode: _focusNode,
                  onChanged: (text) {
                    if (text.trim().isNotEmpty) {
                      _isWriting = true;
                    } else {
                      _isWriting = false;
                    }
                    setState(() {});
                  },
                )),
                IconTheme(
                  data: IconThemeData(color: Colors.blue.shade400),
                  child: IconButton(
                      onPressed: _isWriting
                          ? () => _handleSubmit(_textController.text)
                          : null,
                      icon: const Icon(Icons.send)),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmit(String text) {
    _textController.clear();
    _focusNode.requestFocus();
    _isWriting = false;

    final newMessage = ChatMessage(
      uid: authService.user.uid,
      text: text,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200)),
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    socketService.socket.emit('personal-message', {
      'from': authService.user.uid,
      'to': chatService.user.uid,
      'message': text
    });
    setState(() {});
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    socketService.socket.off('personal-message');
    super.dispose();
  }
}
