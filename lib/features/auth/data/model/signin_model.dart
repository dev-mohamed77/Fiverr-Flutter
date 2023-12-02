// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fiverr/features/profile/data/model/user_model.dart';
import 'package:fiverr/features/auth/domain/entity/signin_entity.dart';

class SignInModel extends SignInEntity {
  final UserModel user;
  SignInModel({
    required this.user,
    required super.token,
  }) : super(user: user);

  SignInModel copyWith({
    UserModel? user,
    String? token,
  }) {
    return SignInModel(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'token': token,
    };
  }

  factory SignInModel.fromMap(Map<String, dynamic> map) {
    return SignInModel(
      user: UserModel.fromMap(map['result'] as Map<String, dynamic>),
      token: map['token'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInModel.fromJson(String source) =>
      SignInModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SignInModel(user: $user, token: $token)';

  @override
  bool operator ==(covariant SignInModel other) {
    if (identical(this, other)) return true;

    return other.user == user && other.token == token;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode;
}
