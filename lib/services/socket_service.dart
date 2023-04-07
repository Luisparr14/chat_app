import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  SocketService() {
    _initConfig();
  }

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  void _initConfig() {
    _socket = IO.io(
        'http://192.168.1.8:3000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .build());

    _socket.onConnect((data) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.onDisconnect((data) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
  }
}