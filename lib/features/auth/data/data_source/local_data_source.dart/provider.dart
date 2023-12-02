import 'package:fiverr/features/auth/data/data_source/local_data_source.dart/user_local_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImp();
});
