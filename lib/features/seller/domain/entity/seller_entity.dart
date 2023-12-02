// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class SellerEntity extends Equatable {
  final String id;
  final String fullName;
  final String displayName;
  final String picture;
  final String description;
  final int balance;
  final SellerUserEntity user;
  final List<SellerLanguageEntity> language;
  final List<SellerOccupationEntity> occupation;
  final List<SellerSkillEntity> skills;
  final String website;

  const SellerEntity({
    required this.id,
    required this.fullName,
    required this.displayName,
    required this.picture,
    required this.description,
    required this.balance,
    required this.user,
    required this.language,
    required this.occupation,
    required this.skills,
    required this.website,
  });

  @override
  List<Object> get props {
    return [
      id,
      fullName,
      displayName,
      picture,
      description,
      balance,
      user,
      language,
      occupation,
      skills,
      website,
    ];
  }
}

class SellerUserEntity extends Equatable {
  final String id;
  final String name;
  final String email;

  const SellerUserEntity({
    required this.id,
    required this.name,
    required this.email,
  });
  @override
  List<Object?> get props => [id, name, email];
}

class SellerLanguageEntity extends Equatable {
  final String id;
  final String language;
  final String level;

  const SellerLanguageEntity({
    required this.id,
    required this.language,
    required this.level,
  });
  @override
  List<Object?> get props => [id, language, level];
}

class SellerOccupationEntity extends Equatable {
  final String id;
  final String occupation;
  final String specialization;
  final String from;
  final String to;

  const SellerOccupationEntity({
    required this.id,
    required this.occupation,
    required this.specialization,
    required this.from,
    required this.to,
  });
  @override
  List<Object?> get props => [id, occupation, specialization, from, to];
}

class SellerSkillEntity extends Equatable {
  final String id;
  final String skill;
  final String level;

  const SellerSkillEntity({
    required this.id,
    required this.skill,
    required this.level,
  });
  @override
  List<Object?> get props => [id, skill, level];
}
