// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';

class SellerModel extends SellerEntity {
  final SellerUserModel user;
  final List<SellerLanguageModel> language;
  final List<SellerOccupationModel> occupation;
  final List<SellerSkillModel> skills;
  const SellerModel({
    required super.id,
    required super.fullName,
    required super.displayName,
    required super.picture,
    required super.description,
    required super.balance,
    required this.user,
    required this.language,
    required this.occupation,
    required this.skills,
    required super.website,
  }) : super(
          user: user,
          language: language,
          occupation: occupation,
          skills: skills,
        );

  SellerModel copyWith({
    String? id,
    String? fullName,
    String? displayName,
    String? picture,
    String? description,
    int? balance,
    SellerUserModel? user,
    List<SellerLanguageModel>? language,
    List<SellerOccupationModel>? occupation,
    List<SellerSkillModel>? skills,
    String? website,
  }) {
    return SellerModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      displayName: displayName ?? this.displayName,
      picture: picture ?? this.picture,
      description: description ?? this.description,
      user: user ?? this.user,
      language: language ?? this.language,
      occupation: occupation ?? this.occupation,
      skills: skills ?? this.skills,
      website: website ?? this.website,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'displayName': displayName,
      'picture': picture,
      'description': description,
      'balance': balance,
      'user': user.toMap(),
      'language': language.map((x) => x.toMap()).toList(),
      'occupation': occupation.map((x) => x.toMap()).toList(),
      'skills': skills.map((x) => x.toMap()).toList(),
      'website': website,
    };
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      id: map['id'] ?? "",
      fullName: map['fullName'] ?? "",
      displayName: map['displayName'] ?? "",
      picture: map['picture'] ?? "",
      description: map['description'] ?? "",
      user: SellerUserModel.fromMap(map['user'] as Map<String, dynamic>),
      language: map.containsKey("language")
          ? List<SellerLanguageModel>.from(
              (map['language'] as List<dynamic>).map<SellerLanguageModel>(
                (x) => SellerLanguageModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      occupation: map.containsKey("occupation")
          ? List<SellerOccupationModel>.from(
              (map['occupation'] as List<dynamic>).map<SellerOccupationModel>(
                (x) => SellerOccupationModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      skills: map.containsKey("skills")
          ? List<SellerSkillModel>.from(
              (map['skills'] as List<dynamic>).map<SellerSkillModel>(
                (x) => SellerSkillModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      website: map['website'] ?? "",
      balance: map['balance'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerModel.fromJson(String source) =>
      SellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SellerModel(id: $id, fullName: $fullName, displayName: $displayName, balance: $balance, picture: $picture, description: $description, user: $user, language: $language, occupation: $occupation, skills: $skills, website: $website)';
  }

  @override
  bool operator ==(covariant SellerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.displayName == displayName &&
        other.picture == picture &&
        other.description == description &&
        other.balance == balance &&
        other.user == user &&
        listEquals(other.language, language) &&
        listEquals(other.occupation, occupation) &&
        listEquals(other.skills, skills) &&
        other.website == website;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        displayName.hashCode ^
        picture.hashCode ^
        description.hashCode ^
        balance.hashCode ^
        user.hashCode ^
        language.hashCode ^
        occupation.hashCode ^
        skills.hashCode ^
        website.hashCode;
  }
}

class SellerUserModel extends SellerUserEntity {
  const SellerUserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  SellerUserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return SellerUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory SellerUserModel.fromMap(Map<String, dynamic> map) {
    return SellerUserModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerUserModel.fromJson(String source) =>
      SellerUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SellerUserModel(id: $id, name: $name, email: $email)';

  @override
  bool operator ==(covariant SellerUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}

class SellerLanguageModel extends SellerLanguageEntity {
  const SellerLanguageModel({
    required super.id,
    required super.language,
    required super.level,
  });

  SellerLanguageModel copyWith({
    String? id,
    String? language,
    String? level,
  }) {
    return SellerLanguageModel(
      id: id ?? this.id,
      language: language ?? this.language,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'language': language,
      'level': level,
    };
  }

  factory SellerLanguageModel.fromMap(Map<String, dynamic> map) {
    return SellerLanguageModel(
      id: map['id'] ?? "",
      language: map['language'] ?? "",
      level: map['level'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerLanguageModel.fromJson(String source) =>
      SellerLanguageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SellerLanguageModel(id: $id, language: $language, level: $level)';

  @override
  bool operator ==(covariant SellerLanguageModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.language == language && other.level == level;
  }

  @override
  int get hashCode => id.hashCode ^ language.hashCode ^ level.hashCode;
}

class SellerOccupationModel extends SellerOccupationEntity {
  const SellerOccupationModel({
    required super.id,
    required super.occupation,
    required super.specialization,
    required super.from,
    required super.to,
  });

  SellerOccupationModel copyWith({
    String? id,
    String? occupation,
    String? specialization,
    String? from,
    String? to,
  }) {
    return SellerOccupationModel(
      id: id ?? this.id,
      occupation: occupation ?? this.occupation,
      specialization: specialization ?? this.specialization,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'occupation': occupation,
      'specialization': specialization,
      'from': from,
      'to': to,
    };
  }

  factory SellerOccupationModel.fromMap(Map<String, dynamic> map) {
    return SellerOccupationModel(
      id: map['id'] ?? "",
      occupation: map['occupation'] ?? "",
      specialization: map['specialization'] ?? "",
      from: map['from'] ?? "",
      to: map['to'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerOccupationModel.fromJson(String source) =>
      SellerOccupationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SellerOccupationModel(id: $id, occupation: $occupation, specialization: $specialization, from: $from, to: $to)';
  }

  @override
  bool operator ==(covariant SellerOccupationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.occupation == occupation &&
        other.specialization == specialization &&
        other.from == from &&
        other.to == to;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        occupation.hashCode ^
        specialization.hashCode ^
        from.hashCode ^
        to.hashCode;
  }
}

class SellerSkillModel extends SellerSkillEntity {
  const SellerSkillModel({
    required super.id,
    required super.skill,
    required super.level,
  });

  SellerSkillModel copyWith({
    String? id,
    String? skill,
    String? level,
  }) {
    return SellerSkillModel(
      id: id ?? this.id,
      skill: skill ?? this.skill,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'skill': skill,
      'level': level,
    };
  }

  factory SellerSkillModel.fromMap(Map<String, dynamic> map) {
    return SellerSkillModel(
      id: map['id'] ?? "",
      skill: map['skill'] ?? "",
      level: map['level'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerSkillModel.fromJson(String source) =>
      SellerSkillModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SellerSkillModel(id: $id, skill: $skill, level: $level)';

  @override
  bool operator ==(covariant SellerSkillModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.skill == skill && other.level == level;
  }

  @override
  int get hashCode => id.hashCode ^ skill.hashCode ^ level.hashCode;
}
