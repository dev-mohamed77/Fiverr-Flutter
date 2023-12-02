import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/occupation/domain/entity/occupation_entity.dart';
import 'package:fiverr/features/occupation/presentation/manager/providers.dart';
import 'package:fiverr/features/occupation/presentation/manager/select_occupation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OccupationItem extends ConsumerWidget {
  const OccupationItem({
    super.key,
    required this.occupation,
    bool? isUpdate,
  }) : _isUpdate = isUpdate ?? false;

  final OccupationEntity occupation;
  final bool _isUpdate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text(
                        occupation.occupation,
                        style: context.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const VerticalSpacer(7),
                      Text(
                        occupation.to,
                        style: context.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        occupation.specialization,
                        style: context.bodyMedium,
                      ),
                      const VerticalSpacer(7),
                      Text(
                        occupation.form,
                        style: context.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              if (_isUpdate)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.update,
                    color: AppColor.primaryColor,
                  ),
                ),
              IconButton(
                onPressed: () {
                  ref
                      .read(deleteOccupationUseCaseProvider.notifier)
                      .execute(id: occupation.id);
                  ref
                      .read(selectDeleteOccupationProvider.notifier)
                      .update((state) => occupation);
                },
                icon: const Icon(
                  Icons.delete,
                  color: AppColor.redColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
