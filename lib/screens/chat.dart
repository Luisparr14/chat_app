import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;

  final List<ChatMessage> _messages = [
    const ChatMessage(uid: '123', text: '¿Como estas?'),
    const ChatMessage(uid: '1223', text: 'Hola'),
    const ChatMessage(uid: '123', text: 'Hola'),
    const ChatMessage(uid: '123', text: 'My primer mensaje'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Column(
          children: [
            CircleAvatar(
              maxRadius: 18,
              child: Text('DA'),
            ),
            SizedBox(height: 2),
            Text('Dante', style: TextStyle(fontSize: 12))
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

    final newMessage = ChatMessage(uid: '123', text: text);

    _messages.insert(0, newMessage);

    setState(() {});
  }
}
