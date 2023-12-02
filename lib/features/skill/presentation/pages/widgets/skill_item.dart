import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/skill/domain/entity/skill_entity.dart';
import 'package:fiverr/features/skill/presentation/manager/providers.dart';
import 'package:fiverr/features/skill/presentation/manager/select_skill_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SkillItem extends ConsumerWidget {
  const SkillItem({
    super.key,
    required this.skill,
    bool? isUpdate,
  }) : _isUpdate = isUpdate ?? false;

  final SkillEntity skill;
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
                    skill.skill,
                    style: context.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    skill.level,
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
                      .read(deleteSkillUseCaseProvider.notifier)
                      .execute(id: skill.id);

                  ref
                      .read(selectDeleteSkillProvider.notifier)
                      .update((state) => skill);
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
