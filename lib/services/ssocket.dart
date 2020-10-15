import 'package:chat/global/env.dart';
import 'package:chat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SSocket with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get svrSt => _serverStatus;

  IO.Socket _socket;
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  void connect() async {
    final tk = await SAuth.getTk();

    _socket = IO.io(Env.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-tk': tk}
    });

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
