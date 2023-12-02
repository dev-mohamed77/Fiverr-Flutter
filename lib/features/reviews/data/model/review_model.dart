// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fiverr/features/reviews/domain/entity/review_entity.dart';

class ReviewModel extends ReviewEntity {
  final List<ReviewDataModel> result;
  const ReviewModel({
    required super.length,
    required this.result,
  }) : super(result: result);

  ReviewModel copyWith({
    int? length,
    List<ReviewDataModel>? result,
  }) {
    return ReviewModel(
      length: length ?? this.length,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'length': length,
      'result': result.map((x) => x.toMap()).toList(),
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      length: map['length'] ?? 0,
      result: List<ReviewDataModel>.from(
        (map['result'] as List<dynamic>).map<ReviewDataModel>(
          (x) => ReviewDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ReviewModel(length: $length, result: $result)';

  @override
  bool operator ==(covariant ReviewModel other) {
    if (identical(this, other)) return true;

    return other.length == length && listEquals(other.result, result);
  }

  @override
  int get hashCode => length.hashCode ^ result.hashCode;
}

class ReviewDataModel extends ReviewDataEntity {
  final UserReviewModel user;
  final GigReviewModel gig;
  const ReviewDataModel({
    required super.id,
    required super.description,
    required super.star,
    required super.createdAt,
    required super.updatedAt,
    required this.user,
    required this.gig,
  }) : super(gig: gig, user: user);

  ReviewDataModel copyWith({
    String? id,
    String? description,
    int? star,
    UserReviewModel? user,
    GigReviewModel? gig,
    String? createdAt,
    String? updatedAt,
  }) {
    return ReviewDataModel(
      id: id ?? this.id,
      description: description ?? this.description,
      star: star ?? this.star,
      user: user ?? this.user,
      gig: gig ?? this.gig,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'star': star,
      'user': user.toMap(),
      'gig': gig.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ReviewDataModel.fromMap(Map<String, dynamic> map) {
    return ReviewDataModel(
      id: map['id'] ?? "",
      description: map['description'] ?? "",
      star: map['star'] ?? 0,
      user: UserReviewModel.fromMap(map['user'] as Map<String, dynamic>),
      gig: GigReviewModel.fromMap(map['gig'] as Map<String, dynamic>),
      createdAt: map["createdAt"] ?? "",
      updatedAt: map["updatedAt"] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewDataModel.fromJson(String source) =>
      ReviewDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewDataModel(id: $id, description: $description, star: $star, user: $user, gig: $gig createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ReviewDataModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.star == star &&
        other.user == user &&
        other.gig == gig &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        star.hashCode ^
        user.hashCode ^
        gig.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class UserReviewModel extends UserReviewEntity {
  const UserReviewModel({
    required super.id,
    required super.name,
    required super.email,
    required super.country,
  });

  UserReviewModel copyWith({
    String? id,
    String? name,
    String? email,
    String? country,
  }) {
    return UserReviewModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'country': country,
    };
  }

  factory UserReviewModel.fromMap(Map<String, dynamic> map) {
    return UserReviewModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      country: map['country'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReviewModel.fromJson(String source) =>
      UserReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserReviewModel(id: $id, name: $name, email: $email, country: $country)';

  @override
  bool operator ==(covariant UserReviewModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.country == country;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ country.hashCode;
}

class GigReviewModel extends GigReviewEntity {
  const GigReviewModel({
    required super.id,
    required super.title,
    required super.coverImage,
  });

  GigReviewModel copyWith({
    String? id,
    String? title,
    String? coverImage,
  }) {
    return GigReviewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      coverImage: coverImage ?? this.coverImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'coverImage': coverImage,
    };
  }

  factory GigReviewModel.fromMap(Map<String, dynamic> map) {
    return GigReviewModel(
      id: map['id'] ?? "",
      title: map['title'] ?? "",
      coverImage: map['coverImage'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory GigReviewModel.fromJson(String source) =>
      GigReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GigReviewModel(id: $id, title: $title, coverImage: $coverImage)';

  @override
  bool operator ==(covariant GigReviewModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.coverImage == coverImage;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ coverImage.hashCode;
}
