// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';

class GigModel extends GigEntity {
  final GigSellerModel seller;
  final GigCategoryModel category;
  final GigSubCategoryModel subCategories;
  final List<GigImageModel> images;

  const GigModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required this.seller,
    required this.category,
    required this.subCategories,
    required this.images,
    required super.coverImage,
    required super.deliveryTime,
    required super.sales,
    required super.averageRating,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  }) : super(
          seller: seller,
          category: category,
          subCategories: subCategories,
          images: images,
        );

  GigModel copyWith({
    String? id,
    String? title,
    String? description,
    int? price,
    GigSellerModel? seller,
    GigCategoryModel? category,
    GigSubCategoryModel? subCategories,
    List<GigImageModel>? images,
    String? coverImage,
    int? deliveryTime,
    int? sales,
    double? averageRating,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    return GigModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      seller: seller ?? this.seller,
      category: category ?? this.category,
      subCategories: subCategories ?? this.subCategories,
      images: images ?? this.images,
      coverImage: coverImage ?? this.coverImage,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      sales: sales ?? this.sales,
      averageRating: averageRating ?? this.averageRating,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'seller': seller.toMap(),
      'category': category.toMap(),
      'subCategories': subCategories.toMap(),
      'images': images.map((x) => x.toMap()).toList(),
      'coverImage': coverImage,
      'deliveryTime': deliveryTime,
      'sales': sales,
      'averageRating': averageRating,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory GigModel.fromMap(Map<String, dynamic> map) {
    return GigModel(
      id: map['id'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      price: map['price'] ?? 0,
      seller: GigSellerModel.fromMap(map['seller'] as Map<String, dynamic>),
      category:
          GigCategoryModel.fromMap(map['category'] as Map<String, dynamic>),
      subCategories: GigSubCategoryModel.fromMap(
          map['subCategories'] as Map<String, dynamic>),
      images: map.containsKey("images")
          ? List<GigImageModel>.from(
              (map['images'] as List).map<GigImageModel>(
                (x) => GigImageModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      coverImage: map['coverImage'] ?? "",
      deliveryTime: map['deliveryTime'] ?? 0,
      sales: map['sales'] ?? 0,
      averageRating: map['averageRating'].runtimeType == int
          ? map['averageRating'].toDouble()
          : map['averageRating'] ?? 0.0,
      isActive: map['isActive'] ?? false,
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory GigModel.fromJson(String source) =>
      GigModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GigModel(id: $id, title: $title, description: $description, price: $price, seller: $seller, category: $category, subCategories: $subCategories, images: $images, coverImage: $coverImage, deliveryTime: $deliveryTime, sales: $sales, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant GigModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.category == category &&
        other.subCategories == subCategories &&
        listEquals(other.images, images) &&
        other.coverImage == coverImage &&
        other.deliveryTime == deliveryTime &&
        other.sales == sales &&
        other.averageRating == averageRating &&
        other.isActive == isActive &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        seller.hashCode ^
        category.hashCode ^
        subCategories.hashCode ^
        images.hashCode ^
        coverImage.hashCode ^
        deliveryTime.hashCode ^
        sales.hashCode ^
        averageRating.hashCode ^
        isActive.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class GigSellerModel extends GigSellerEntity {
  const GigSellerModel({
    required super.id,
    required super.displayName,
    required super.picture,
  });

  GigSellerModel copyWith({
    String? id,
    String? displayName,
    String? picture,
  }) {
    return GigSellerModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'displayName': displayName,
      'picture': picture,
    };
  }

  factory GigSellerModel.fromMap(Map<String, dynamic> map) {
    return GigSellerModel(
      id: map['id'] ?? "",
      displayName:
          map.containsKey("displayName") ? map['displayName'] ?? "" : "",
      picture: map.containsKey("picture") ? map['picture'] ?? "" : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory GigSellerModel.fromJson(String source) =>
      GigSellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GigSeller(id: $id, displayName: $displayName , picture: $picture)';

  @override
  bool operator ==(covariant GigSellerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.displayName == displayName &&
        other.picture == picture;
  }

  @override
  int get hashCode => id.hashCode ^ displayName.hashCode ^ picture.hashCode;
}

class GigCategoryModel extends GigCategoryEntity {
  const GigCategoryModel({
    required super.id,
    required super.name,
    required super.src,
  });

  GigCategoryModel copyWith({
    String? id,
    String? name,
    String? src,
  }) {
    return GigCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      src: src ?? this.src,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'src': src,
    };
  }

  factory GigCategoryModel.fromMap(Map<String, dynamic> map) {
    return GigCategoryModel(
      id: map['id'] ?? "",
      name: map.containsKey("name") ? map['name'] ?? "" : "",
      src: map.containsKey("src") ? map['src'] ?? "" : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory GigCategoryModel.fromJson(String source) =>
      GigCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GigCategoryModel(id: $id, name: $name, src: $src)';

  @override
  bool operator ==(covariant GigCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.src == src;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ src.hashCode;
}

class GigSubCategoryModel extends GigSubCategoryEntity {
  const GigSubCategoryModel({
    required super.id,
    required super.name,
  });

  GigSubCategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return GigSubCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory GigSubCategoryModel.fromMap(Map<String, dynamic> map) {
    return GigSubCategoryModel(
      id: map['id'] ?? "",
      name: map.containsKey("name") ? map['name'] ?? "" : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory GigSubCategoryModel.fromJson(String source) =>
      GigSubCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GigSubCategoryModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant GigSubCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class GigImageModel extends GigImageEntity {
  const GigImageModel({
    required super.id,
    required super.src,
  });

  GigImageModel copyWith({
    String? id,
    String? src,
  }) {
    return GigImageModel(
      id: id ?? this.id,
      src: src ?? this.src,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'src': src,
    };
  }

  factory GigImageModel.fromMap(Map<String, dynamic> map) {
    return GigImageModel(
      id: map['id'] ?? "",
      src: map.containsKey("src") ? map['src'] ?? "" : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory GigImageModel.fromJson(String source) =>
      GigImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GigImageModel(id: $id, src: $src)';

  @override
  bool operator ==(covariant GigImageModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.src == src;
  }

  @override
  int get hashCode => id.hashCode ^ src.hashCode;
}
