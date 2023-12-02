import 'package:fiverr/features/language/domain/entity/language_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectSellerLanguageProvider = StateProvider<String?>((ref) => null);
final selectSellerLanguageLevelProvider = StateProvider<String?>((ref) => null);

final selectDeleteLanguageProvider =
    StateProvider<LanguageEntity?>((ref) => null);
