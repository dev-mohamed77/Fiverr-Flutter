// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fiverr/core/common/entity/seller_custom_entity.dart';

class LanguageEntity extends Equatable {
  final String id;
  final String language;
  final String level;
  final SellerCustomEntity seller;
  final String createdAt;
  final String updatedAt;

  const LanguageEntity({
    required this.id,
    required this.language,
    required this.level,
    required this.seller,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [id, language, level, seller, createdAt, updatedAt];
}
