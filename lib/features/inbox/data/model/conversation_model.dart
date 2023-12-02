// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fiverr/features/inbox/data/model/conversation_data_model.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  final List<ConversationDataModel> result;
  const ConversationModel({
    required super.status,
    required super.length,
    required this.result,
  }) : super(result: result);

  ConversationModel copyWith({
    bool? status,
    int? length,
    List<ConversationDataModel>? result,
  }) {
    return ConversationModel(
      status: status ?? this.status,
      length: length ?? this.length,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'length': length,
      'result': result.map((x) => x.toMap()).toList(),
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      status: map['status'] ?? false,
      length: map['length'] ?? 0,
      result: List<ConversationDataModel>.from(
        (map['result'] as List<dynamic>).map<ConversationDataModel>(
          (x) => ConversationDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) =>
      ConversationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ConversationModel(status: $status, length: $length, result: $result)';

  @override
  bool operator ==(covariant ConversationModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.length == length &&
        listEquals(other.result, result);
  }

  @override
  int get hashCode => status.hashCode ^ length.hashCode ^ result.hashCode;
}
