// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fiverr/features/profile/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.gender,
    required super.phone,
    required super.age,
    required super.country,
    required super.isSeller,
    required super.roles,
    required super.passwordChangedAt,
    required super.passwordResetCode,
    required super.passwordResetExpires,
    required super.passwordResetVerified,
    required super.createAt,
    required super.updatedAt,
  });

  UserModel copyWith({
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
    return UserModel(
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'phone': phone,
      'age': age,
      'country': country,
      'isSeller': isSeller,
      'roles': roles,
      'passwordChangedAt': passwordChangedAt,
      'passwordResetCode': passwordResetCode,
      'passwordResetExpires': passwordResetExpires,
      'passwordResetVerified': passwordResetVerified,
      'createAt': createAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      gender: map['gender'] ?? "",
      phone: map['phone'] ?? "",
      age: map['age'] ?? 0,
      country: map['country'] ?? "",
      isSeller: map['isSeller'] ?? false,
      roles: map['roles'] ?? "",
      passwordChangedAt: map['passwordChangedAt'] ?? "",
      passwordResetCode: map['passwordResetCode'] ?? "",
      passwordResetExpires: map['passwordResetExpires'] ?? "",
      passwordResetVerified: map['passwordResetVerified'] ?? false,
      createAt: map['createAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, gender: $gender, phone: $phone, age: $age, country: $country, isSeller: $isSeller, roles: $roles, passwordChangedAt: $passwordChangedAt, passwordResetCode: $passwordResetCode, passwordResetExpires: $passwordResetExpires, passwordResetVerified: $passwordResetVerified, createAt: $createAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.gender == gender &&
        other.phone == phone &&
        other.age == age &&
        other.country == country &&
        other.isSeller == isSeller &&
        other.roles == roles &&
        other.passwordChangedAt == passwordChangedAt &&
        other.passwordResetCode == passwordResetCode &&
        other.passwordResetExpires == passwordResetExpires &&
        other.passwordResetVerified == passwordResetVerified &&
        other.createAt == createAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        age.hashCode ^
        country.hashCode ^
        isSeller.hashCode ^
        roles.hashCode ^
        passwordChangedAt.hashCode ^
        passwordResetCode.hashCode ^
        passwordResetExpires.hashCode ^
        passwordResetVerified.hashCode ^
        createAt.hashCode ^
        updatedAt.hashCode;
  }
}
