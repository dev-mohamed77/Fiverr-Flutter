// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MyListEntity extends Equatable {
  final String id;
  final MyListUserEntity user;
  final MyListGigEntity gig;
  final String createdAt;
  final String updatedAt;

  const MyListEntity({
    required this.id,
    required this.user,
    required this.gig,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  List<Object> get props {
    return [
      id,
      user,
      gig,
      createdAt,
      updatedAt,
    ];
  }
}

class MyListUserEntity extends Equatable {
  final String id;
  final String name;
  final String email;

  const MyListUserEntity({
    required this.id,
    required this.name,
    required this.email,
  });
  @override
  List<Object> get props => [id, name, email];
}

class MyListGigEntity extends Equatable {
  final String id;
  final String title;
  final int price;
  final String coverImage;

  const MyListGigEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.coverImage,
  });

  @override
  List<Object> get props => [id, title, price, coverImage];
}
