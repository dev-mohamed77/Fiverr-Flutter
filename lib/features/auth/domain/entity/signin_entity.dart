// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fiverr/features/profile/domain/entity/user_entity.dart';

class SignInEntity extends Equatable {
  final UserEntity user;
  final String token;

  const SignInEntity({
    required this.user,
    required this.token,
  });

  @override
  List<Object?> get props => [user, token];
}
