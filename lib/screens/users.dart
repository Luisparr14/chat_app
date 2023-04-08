import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/models/user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final userService = UserService();

  List<User> users = [];

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final user = authService.user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(user.name, textAlign: TextAlign.right),
        leading: IconButton(
          onPressed: () {
            authService.logOut();
            Navigator.pushReplacementNamed(context, 'login');
            socketService.disconnect();
          },
          icon: const Icon(Icons.exit_to_app),
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: connectionStatus(socketService)
              // Icon(Icons.offline_bolt_outlined, color: Colors.red[400])
              )
        ],
      ),
      body: SmartRefresher(
          controller: _refreshController,
          header: const WaterDropMaterialHeader(distance: 25),
          onRefresh: _loadUsers,
          child: _usersListView()),
    );
  }

  Widget connectionStatus(SocketService socketService) {
    bool isConnected = socketService.serverStatus == ServerStatus.online;

    return isConnected
        ? Icon(Icons.online_prediction_sharp, color: Colors.green[400])
        : Icon(Icons.offline_bolt, color: Colors.red[400]);
  }

  ListView _usersListView() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) => _usersListTile(users[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: users.length);
  }

  ListTile _usersListTile(User user) {
    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(
        child: Text(user.name.toUpperCase().substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: user.online ? Colors.green.shade500 : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      subtitle: Text(user.email),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.user = user;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  void _loadUsers() async {
    users = await userService.getUsers();
    _refreshController.refreshCompleted();
    setState(() {});
  }
}
