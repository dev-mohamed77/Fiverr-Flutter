// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/inbox/data/model/conversation_data_model.dart';
import 'package:fiverr/features/inbox/data/model/conversation_model.dart';

abstract class ConversationRemoteDataSource {
  Future<ConversationDataModel> createConversation({
    required String sellerID,
  });
  Future<ConversationModel> getConversationsBySellerId({
    required String sellerID,
    String? limit,
    String? page,
  });
  Future<ConversationModel> getConversationsByUserId({
    String? limit,
    String? page,
  });

  Future<ConversationDataModel?> getConversationByUserIdAndSellerId({
    required String sellerID,
    required String userID,
  });
}

class ConversationRemoteDataSourceImp implements ConversationRemoteDataSource {
  final NetWorkService netWorkService;
  ConversationRemoteDataSourceImp({
    required this.netWorkService,
  });

  @override
  Future<ConversationDataModel> createConversation({
    required String sellerID,
  }) async {
    final response = await netWorkService.postData("conversation", data: {
      "seller": sellerID,
    });

    final data = response.data["result"];

    return ConversationDataModel.fromMap(data);
  }

  @override
  Future<ConversationDataModel?> getConversationByUserIdAndSellerId({
    required String sellerID,
    required String userID,
  }) async {
    final response = await netWorkService.getData(
      "conversation/seller-user",
      data: {
        "seller": sellerID,
        "user": userID,
      },
    );

    final data = response.data["result"];
    if (data != null) {
      return ConversationDataModel.fromMap(data);
    } else {
      return null;
    }
  }

  @override
  Future<ConversationModel> getConversationsBySellerId({
    required String sellerID,
    String? limit,
    String? page,
  }) async {
    final response = await netWorkService.getData(
      "$sellerID/conversation-seller",
      queryParams: {
        "page": page,
        "limit": limit,
      },
    );

    final data = response.data;

    return ConversationModel.fromMap(data);
  }

  @override
  Future<ConversationModel> getConversationsByUserId({
    String? limit,
    String? page,
  }) async {
    final response = await netWorkService.getData(
      "conversation-user",
      queryParams: {
        "page": page,
        "limit": limit,
      },
    );

    final data = response.data;

    return ConversationModel.fromMap(data);
  }
}
