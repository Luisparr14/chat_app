import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final users = [
    User(name: 'Luis', email: 'test1@test,com', online: true, uid: '1'),
    User(name: 'Daniel', email: 'test2@test,com', online: false, uid: '2'),
    User(name: 'Diana', email: 'test3@test,com', online: true, uid: '3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text('Chat', textAlign: TextAlign.right),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.exit_to_app),
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child:
                  // Icon(Icons.bolt, color: Colors.green[400])
                  Icon(Icons.offline_bolt_outlined, color: Colors.red[400]))
        ],
      ),
      body: Center(
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, i) => ListTile(
                  title: Text(users[i].name),
                  leading: CircleAvatar(
                    child: Text(users[i].name.toUpperCase().substring(0, 2)),
                  ),
                  trailing: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: users[i].online
                            ? Colors.green.shade500
                            : Colors.red,
                        borderRadius: BorderRadius.circular(100)),
                  )),
              separatorBuilder: (_, i) => const Divider(),
              itemCount: users.length)),
    );
  }
}
