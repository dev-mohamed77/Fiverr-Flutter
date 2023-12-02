// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/chat/data/model/messages_model.dart';

abstract class MessagesRemoteDataSource {
  Future<MessagesModel> getMessagesByConversationID({
    required String conversationId,
    String? limit,
    String? page,
  });

  Future<String> deleteCategoryByID(
    String id, {
    required String sender,
    required String conversationId,
    required String sellerId,
    required String userId,
  });
}

class MessagesRemoteDataSourceImp implements MessagesRemoteDataSource {
  final NetWorkService netWorkService;
  MessagesRemoteDataSourceImp({
    required this.netWorkService,
  });

  @override
  Future<MessagesModel> getMessagesByConversationID({
    required String conversationId,
    String? limit,
    String? page,
  }) async {
    final response = await netWorkService.getData(
      "messages/$conversationId/conversation",
      queryParams: {
        "limit": limit,
        "page": page,
      },
    );

    final data = response.data;

    return MessagesModel.fromMap(data);
  }

  @override
  Future<String> deleteCategoryByID(
    String id, {
    required String sender,
    required String conversationId,
    required String sellerId,
    required String userId,
  }) async {
    final response = await netWorkService.deleteData("messages/$id", data: {
      "sender": sender,
      "conversation": conversationId,
      "seller": sellerId,
      "user": userId,
    });

    final data = response.data["result"];

    return data;
  }
}
