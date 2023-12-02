// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fiverr/features/explore/data/model/category_model.dart';
import 'package:fiverr/features/subcategory/domain/entity/sub_category_entity.dart';

class SubCategoryModel extends SubCategoryEntity {
  final CategoryModel category;

  const SubCategoryModel({
    required super.id,
    required super.name,
    required this.category,
  }) : super(category: category);

  SubCategoryModel copyWith({
    String? id,
    String? name,
    CategoryModel? category,
  }) {
    return SubCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category.toMap(),
    };
  }

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      category: CategoryModel.fromMap(map['category'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategoryModel.fromJson(String source) =>
      SubCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubCategoryModel(id: $id, name: $name, category: $category)';

  @override
  bool operator ==(covariant SubCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.category == category;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ category.hashCode;
}
