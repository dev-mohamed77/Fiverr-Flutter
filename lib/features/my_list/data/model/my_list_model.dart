// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:fiverr/features/my_list/domain/entity/my_list_entity.dart';

class MyListModel extends MyListEntity {
  final MyListUserModel user;
  final MyListGigModel gig;
  const MyListModel({
    required super.id,
    required this.user,
    required this.gig,
    required super.createdAt,
    required super.updatedAt,
  }) : super(gig: gig, user: user);

  MyListModel copyWith({
    String? id,
    MyListUserModel? user,
    MyListGigModel? gig,
    String? createdAt,
    String? updatedAt,
  }) {
    return MyListModel(
      id: id ?? this.id,
      user: user ?? this.user,
      gig: gig ?? this.gig,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
      'gig': gig.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory MyListModel.fromMap(Map<String, dynamic> map) {
    return MyListModel(
      id: map['id'] ?? "",
      user: MyListUserModel.fromMap(map['user'] as Map<String, dynamic>),
      gig: MyListGigModel.fromMap(map['gig'] as Map<String, dynamic>),
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MyListModel.fromJson(String source) =>
      MyListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyListModel(id: $id, user: $user, gig: $gig, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant MyListModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.gig == gig &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        gig.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class MyListUserModel extends MyListUserEntity {
  const MyListUserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  MyListUserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return MyListUserModel(
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

  factory MyListUserModel.fromMap(Map<String, dynamic> map) {
    return MyListUserModel(
      id: map['id'] ?? "",
      name: map.containsKey('name') ? map['name'] : "",
      email: map.containsKey('email') ? map['email'] : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MyListUserModel.fromJson(String source) =>
      MyListUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MyListUserModel(id: $id, name: $name, email: $email)';

  @override
  bool operator ==(covariant MyListUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}

class MyListGigModel extends MyListGigEntity {
  const MyListGigModel({
    required super.id,
    required super.title,
    required super.price,
    required super.coverImage,
  });

  MyListGigModel copyWith({
    String? id,
    String? title,
    int? price,
    String? coverImage,
  }) {
    return MyListGigModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      coverImage: coverImage ?? this.coverImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'coverImage': coverImage,
    };
  }

  factory MyListGigModel.fromMap(Map<String, dynamic> map) {
    return MyListGigModel(
      id: map['id'] ?? "",
      title: map.containsKey('title') ? map['title'] : "",
      price: map.containsKey('price') ? map['price'] : 0,
      coverImage: map.containsKey('coverImage') ? map['coverImage'] : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MyListGigModel.fromJson(String source) =>
      MyListGigModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyListGigModel(id: $id, title: $title, price: $price, coverImage: $coverImage)';
  }

  @override
  bool operator ==(covariant MyListGigModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.price == price &&
        other.coverImage == coverImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ price.hashCode ^ coverImage.hashCode;
  }
}
