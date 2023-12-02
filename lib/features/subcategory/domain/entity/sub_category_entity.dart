// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:fiverr/features/explore/domain/entity/category_entity.dart';

class SubCategoryEntity extends Equatable {
  final String id;
  final String name;
  final CategoryEntity category;

  const SubCategoryEntity({
    required this.id,
    required this.name,
    required this.category,
  });

  @override
  List<Object> get props => [id, name, category];
}
