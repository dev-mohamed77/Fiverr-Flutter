import 'dart:async';

import 'package:fiverr/features/my_list/domain/entity/my_list_entity.dart';
import 'package:fiverr/features/my_list/domain/repository/provider.dart';
import 'package:fiverr/features/my_list/domain/usecase/add_favorite.dart';
import 'package:fiverr/features/my_list/domain/usecase/delete_favorite.dart';
import 'package:fiverr/features/my_list/domain/usecase/get_favorites_by_user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addFavoriteUseCaseProvider = StateNotifierProvider.autoDispose<
    AddFavoriteUseCase, AsyncValue<MyListEntity?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final myListRepository = ref.watch(myListRepositoryProvider);
  return AddFavoriteUseCase(myListRepository);
});

final getFavoritesByUserUseCaseProvider = StateNotifierProvider.autoDispose<
    GetFavoritesByUserUseCase, AsyncValue<List<MyListEntity>?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final myListRepository = ref.watch(myListRepositoryProvider);
  return GetFavoritesByUserUseCase(myListRepository);
});

final deleteFavoriteUseCaseProvider = StateNotifierProvider.autoDispose<
    DeleteFavoriteUseCase, AsyncValue<String?>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final myListRepository = ref.watch(myListRepositoryProvider);
  return DeleteFavoriteUseCase(myListRepository);
});
