// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fiverr/features/explore/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.src,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? src,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      src: name ?? this.src,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'src': src,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      src: map['src'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryModel(id: $id, name: $name, src: $src)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
