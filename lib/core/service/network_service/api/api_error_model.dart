// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ErrorModel {
  final dynamic message;
  final int statusCode;
  ErrorModel({
    required this.message,
    required this.statusCode,
  });

  ErrorModel copyWith({
    dynamic message,
    int? statusCode,
  }) {
    return ErrorModel(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'statusCode': statusCode,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      message:
          map['message'] == List ? List.from(map["message"]) : map['message'],
      statusCode: map['statusCode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ErrorModel(message: $message, statusCode: $statusCode)';

  @override
  bool operator ==(covariant ErrorModel other) {
    if (identical(this, other)) return true;

    return other.message == message && other.statusCode == statusCode;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode;
}
