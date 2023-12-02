// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class GigEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final int price;
  final GigSellerEntity seller;
  final GigCategoryEntity category;
  final GigSubCategoryEntity subCategories;
  final List<GigImageEntity> images;
  final String coverImage;
  final int deliveryTime;
  final int sales;
  final double averageRating;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  const GigEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.seller,
    required this.category,
    required this.subCategories,
    required this.images,
    required this.coverImage,
    required this.deliveryTime,
    required this.sales,
    required this.averageRating,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      price,
      seller,
      category,
      subCategories,
      images,
      coverImage,
      deliveryTime,
      sales,
      isActive,
      createdAt,
      updatedAt,
    ];
  }
}

class GigSubCategoryEntity extends Equatable {
  final String id;
  final String name;
  const GigSubCategoryEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}

class GigSellerEntity extends Equatable {
  final String id;
  final String displayName;
  final String picture;
  const GigSellerEntity({
    required this.id,
    required this.displayName,
    required this.picture,
  });

  @override
  List<Object> get props => [id, displayName, picture];
}

class GigCategoryEntity extends Equatable {
  final String id;
  final String name;
  final String src;
  const GigCategoryEntity({
    required this.id,
    required this.name,
    required this.src,
  });

  @override
  List<Object> get props => [id, name];
}

class GigImageEntity extends Equatable {
  final String id;
  final String src;
  const GigImageEntity({
    required this.id,
    required this.src,
  });

  @override
  List<Object> get props => [id, src];
}
