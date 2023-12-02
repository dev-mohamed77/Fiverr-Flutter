import 'package:equatable/equatable.dart';

class ConversationSellerEntity extends Equatable {
  final String id;
  final String fullName;
  final String displayName;
  final String picture;

  const ConversationSellerEntity({
    required this.id,
    required this.fullName,
    required this.displayName,
    required this.picture,
  });

  @override
  List<Object> get props => [id, fullName, displayName, picture];
}
