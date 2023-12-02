import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/language/domain/entity/language_entity.dart';
import 'package:fiverr/features/language/presentation/manager/providers.dart';
import 'package:fiverr/features/language/presentation/manager/select_language_and_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageItem extends ConsumerWidget {
  const LanguageItem({
    super.key,
    required this.language,
    bool? isUpdate,
  }) : _isUpdate = isUpdate ?? false;

  final LanguageEntity language;
  final bool _isUpdate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    language.language,
                    style: context.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    language.level,
                    style: context.bodyMedium,
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
                      .read(deleteLanguageUseCaseProvider.notifier)
                      .execute(id: language.id);
                  ref
                      .read(selectDeleteLanguageProvider.notifier)
                      .update((state) => language);
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
