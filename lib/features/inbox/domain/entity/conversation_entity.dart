// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_data_entity.dart';

class ConversationEntity extends Equatable {
  final bool status;
  final int length;
  final List<ConversationDataEntity> result;

  const ConversationEntity({
    required this.status,
    required this.length,
    required this.result,
  });

  @override
  List<Object> get props => [status, length, result];
}
