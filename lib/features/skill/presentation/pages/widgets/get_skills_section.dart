import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/skill/presentation/manager/providers.dart';
import 'package:fiverr/features/skill/presentation/manager/select_skill_manager.dart';
import 'package:fiverr/features/skill/presentation/pages/widgets/skill_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GetSkillsSection extends ConsumerWidget {
  const GetSkillsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skills = ref.watch(getSkillsBySellerIdUseCaseProvider);
    ref.listen(deleteSkillUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showToast(
            message: data!,
            color: AppColor.primaryColor,
            gravity: ToastGravity.TOP,
          );

          final skill = ref.watch(selectDeleteSkillProvider);

          if (skill != null) {
            ref
                .read(getSkillsBySellerIdUseCaseProvider.notifier)
                .deleteSkill(skill);

            ref
                .read(selectDeleteSkillProvider.notifier)
                .update((state) => null);
          }
        },
        error: (error, stackTrace) {
          DialogCustom.showToast(
            message: error.toString(),
            color: AppColor.redColor,
          );
        },
      );
    });
    return AsyncValueWidget(
      value: skills,
      data: (data) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data!.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return SkillItem(skill: data[index]);
          },
        );
      },
    );
  }
}
