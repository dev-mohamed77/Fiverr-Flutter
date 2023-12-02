import 'package:fiverr/features/explore/domain/entity/category_entity.dart';
import 'package:fiverr/features/subcategory/domain/entity/sub_category_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectGigCategoryProvider =
    StateProvider.autoDispose<CategoryEntity?>((ref) => null);

final selectGigSubCategoryProvider =
    StateProvider.autoDispose<SubCategoryEntity?>((ref) => null);
