import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketManager {
  late IO.Socket channel;

  WebSocketManager._() {
    initConnection();
  }

  factory WebSocketManager() {
    return WebSocketManager._();
  }

  void initConnection() {
    channel = IO.io(
        'http://192.168.1.6:3000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());

    if (!channel.connected) {
      channel.connect();
    }

    _connectSocket();
  }

  _connectSocket() {
    channel.onConnect((data) {
      print("connect $data");
    });
    channel.onConnectError((data) {
      print("onConnectError $data");
    });
    channel.onDisconnect((data) {
      print("onDisconnect $data");
    });
  }
}

final webSocketManagerProvider = Provider((ref) => WebSocketManager());
