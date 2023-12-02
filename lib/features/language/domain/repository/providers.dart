import 'package:fiverr/features/language/data/data_source/providers.dart';
import 'package:fiverr/features/language/data/repository/language_repository.dart';
import 'package:fiverr/features/language/domain/repository/language_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageRepositoryProvider = Provider<ILanguageRepository>((ref) {
  final dataSource = ref.watch(languageRemoteDataSourceProvider);

  return LanguageRepositoryImp(remoteDataSource: dataSource);
});
