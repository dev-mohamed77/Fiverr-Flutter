// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String gender;
  final String phone;
  final int age;
  final String country;
  final bool isSeller;
  final String roles;
  final String passwordChangedAt;
  final String passwordResetCode;
  final String passwordResetExpires;
  final bool passwordResetVerified;
  final String createAt;
  final String updatedAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.phone,
    required this.age,
    required this.country,
    required this.isSeller,
    required this.roles,
    required this.passwordChangedAt,
    required this.passwordResetCode,
    required this.passwordResetExpires,
    required this.passwordResetVerified,
    required this.createAt,
    required this.updatedAt,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? gender,
    String? phone,
    int? age,
    String? country,
    bool? isSeller,
    String? roles,
    String? passwordChangedAt,
    String? passwordResetCode,
    String? passwordResetExpires,
    bool? passwordResetVerified,
    String? createAt,
    String? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      country: country ?? this.country,
      isSeller: isSeller ?? this.isSeller,
      roles: roles ?? this.roles,
      passwordChangedAt: passwordChangedAt ?? this.passwordChangedAt,
      passwordResetCode: passwordResetCode ?? this.passwordResetCode,
      passwordResetExpires: passwordResetExpires ?? this.passwordResetExpires,
      passwordResetVerified:
          passwordResetVerified ?? this.passwordResetVerified,
      createAt: createAt ?? this.createAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      gender,
      phone,
      age,
      country,
      isSeller,
      roles,
      passwordChangedAt,
      passwordResetCode,
      passwordResetExpires,
      passwordResetVerified,
      createAt,
      updatedAt,
    ];
  }
}
