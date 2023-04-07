import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
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

  final users = [
    User(name: 'Luis', email: 'test1@test,com', online: true, uid: '1'),
    User(name: 'Daniel', email: 'test2@test,com', online: false, uid: '2'),
    User(name: 'Diana', email: 'test3@test,com', online: true, uid: '3'),
  ];

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
          onRefresh: _onRefresh,
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
        ));
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
