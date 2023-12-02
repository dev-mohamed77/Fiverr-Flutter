import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/centered_message.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/my_list/domain/entity/my_list_entity.dart';
import 'package:fiverr/features/my_list/presentation/manager/providers.dart';
import 'package:fiverr/features/my_list/presentation/manager/select_favorite_provider.dart';
import 'package:fiverr/features/my_list/presentation/pages/widgets/favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyListBody extends ConsumerWidget {
  const MyListBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(getFavoritesByUserUseCaseProvider);

    ref.listen(
      deleteFavoriteUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: data.toString(),
              color: AppColor.primaryColor,
            );

            final favorite = ref.watch(selectFavoriteProvider);

            ref
                .read(getFavoritesByUserUseCaseProvider.notifier)
                .deleteFavorite(favorite?.id ?? "");

            ref.read(selectFavoriteProvider.notifier).update((state) => null);
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(
              message: error.toString(),
              color: AppColor.redColor,
            );
          },
        );
      },
    );

    return AsyncValueWidget<List<MyListEntity>?>(
      value: favorites,
      data: (data) {
        if (data!.isEmpty) {
          return const CenteredMessage("Not Data yet.");
        }

        return ListView.separated(
          itemBuilder: (context, index) {
            final favorite = data[index];
            return FavoriteItem(
              entity: favorite,
              onClick: () {},
            );
          },
          separatorBuilder: (context, index) {
            return const VerticalSpacer(10);
          },
          itemCount: data.length,
        );
      },
    );
  }
}
