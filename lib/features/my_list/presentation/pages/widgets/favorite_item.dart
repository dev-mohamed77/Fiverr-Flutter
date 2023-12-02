import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/my_list/domain/entity/my_list_entity.dart';
import 'package:fiverr/features/my_list/presentation/manager/providers.dart';
import 'package:fiverr/features/my_list/presentation/manager/select_favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    super.key,
    required this.entity,
    required this.onClick,
    bool? isFavorite,
  });

  final MyListEntity entity;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: AppColor.whiteColor,
        surfaceTintColor: AppColor.whiteColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onClick,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(13),
                  topLeft: Radius.circular(13),
                ),
                child: Image.network(
                  entity.gig.coverImage,
                  height: 120,
                  width: context.width / 2.8,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              return GestureDetector(
                                onTap: () {
                                  ref
                                      .read(deleteFavoriteUseCaseProvider
                                          .notifier)
                                      .execute(myListId: entity.gig.id);

                                  ref
                                      .read(selectFavoriteProvider.notifier)
                                      .update((state) => entity);
                                },
                                child: const Icon(
                                  Icons.favorite,
                                  color: AppColor.greyColor,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        entity.gig.title,
                        style: context.bodyMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          const Spacer(),
                          Text(
                            "From",
                            style: context.bodySmall,
                          ),
                          const HorizontalSpacer(5),
                          Text(
                            "\$${entity.gig.price}",
                            style: context.titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
