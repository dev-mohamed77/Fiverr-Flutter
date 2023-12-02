// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final int length;
  final List<ReviewDataEntity> result;

  const ReviewEntity({
    required this.length,
    required this.result,
  });

  @override
  List<Object> get props => [length, result];
}

class ReviewDataEntity extends Equatable {
  final String id;
  final String description;
  final int star;
  final UserReviewEntity user;
  final GigReviewEntity gig;
  final String createdAt;
  final String updatedAt;

  const ReviewDataEntity({
    required this.id,
    required this.description,
    required this.star,
    required this.user,
    required this.gig,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      description,
      star,
      user,
      gig,
      createdAt,
      updatedAt,
    ];
  }
}

class UserReviewEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String country;
  const UserReviewEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.country,
  });

  @override
  List<Object> get props => [id, name, email, country];
}

class GigReviewEntity extends Equatable {
  final String id;
  final String title;
  final String coverImage;
  const GigReviewEntity({
    required this.id,
    required this.title,
    required this.coverImage,
  });

  @override
  List<Object> get props => [id, title, coverImage];
}
