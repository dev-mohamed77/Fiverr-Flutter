// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/web_socket/web_socket_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final joinRoomSocketProvider = Provider.family((ref, JoinRoomModel model) {
  final socketManager = ref.watch(webSocketManagerProvider);
  socketManager.channel.emit("joinRoom", model.toMap());
});

class JoinRoomModel {
  final String userId;
  final String sellerId;
  JoinRoomModel({
    required this.userId,
    required this.sellerId,
  });

  Map<String, dynamic> toMap() {
    return {
      "seller": sellerId,
      "user": userId,
    };
  }
}
