import 'package:dropdown_search/dropdown_search.dart';
import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/skill/presentation/manager/providers.dart';
import 'package:fiverr/features/skill/presentation/manager/select_skill_manager.dart';
import 'package:fiverr/features/skill/presentation/manager/skill_level_manager.dart';
import 'package:fiverr/features/skill/presentation/pages/widgets/get_skills_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SkillBody extends ConsumerStatefulWidget {
  const SkillBody({
    super.key,
    required this.sellerId,
  });

  final String sellerId;

  @override
  ConsumerState<SkillBody> createState() => _SkillBodyState();
}

class _SkillBodyState extends ConsumerState<SkillBody> {
  late TextEditingController skillController;

  @override
  void initState() {
    skillController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    skillController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final createSkill = ref.watch(createSkillUseCaseProvider);
    _createSkillListen(ref, context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacer(15),
                  LoadingLinearProgress(value: createSkill),
                  const VerticalSpacer(15),
                  Column(
                    children: [
                      TextFormFieldCustom(
                        height: 48,
                        label: "Skill",
                        controller: skillController,
                        onChanged: (value) {
                          ref
                              .read(selectSellerSkillProvider.notifier)
                              .update((state) => value);
                        },
                      ),
                      const VerticalSpacer(20),
                      DropdownSearch<String>(
                        popupProps: const PopupProps.menu(
                          showSelectedItems: true,
                        ),
                        items: skillLevel,
                        selectedItem:
                            ref.watch(selectSellerSkillLevelProvider) ??
                                "Level",
                        onChanged: (value) {
                          ref
                              .read(selectSellerSkillLevelProvider.notifier)
                              .update((state) => value);
                        },
                      ),
                    ],
                  ),
                  const VerticalSpacer(20),
                  const GetSkillsSection(),
                  const VerticalSpacer(20),
                ],
              ),
            ),
          ),
          Container(
            width: context.width,
            height: context.height * 0.1,
            padding: const EdgeInsets.symmetric(vertical: 14.5),
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, _) {
                return AppButton(
                  title: "Add Skill",
                  onPressed: () {
                    _createSkill(ref: ref);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _createSkillListen(WidgetRef ref, BuildContext ctx) {
    ref.listen(
      createSkillUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "The Skill has been created successfully",
              color: AppColor.primaryColor,
              gravity: ToastGravity.TOP,
            );
            ref
                .read(selectSellerSkillProvider.notifier)
                .update((state) => null);
            ref
                .read(selectSellerSkillLevelProvider.notifier)
                .update((state) => null);
            ref
                .read(getSkillsBySellerIdUseCaseProvider.notifier)
                .addSkill(data!);
          },
          error: (error, stackTrace) {
            DialogCustom.showSnackBar(
              ctx,
              message: error.toString(),
              color: AppColor.redColor,
            );
          },
        );
      },
    );
  }

  _createSkill({
    required WidgetRef ref,
  }) {
    final skill = ref.watch(selectSellerSkillProvider);
    final level = ref.watch(selectSellerSkillLevelProvider);

    if (skill == null || level == null) {
      DialogCustom.showToast(
        message: "You must choose the skill and level",
        color: AppColor.redColor,
        gravity: ToastGravity.TOP,
      );
    } else {
      ref
          .read(createSkillUseCaseProvider.notifier)
          .execute(
            skill: skill,
            level: level,
            sellerId: widget.sellerId,
          )
          .then((_) {
        skillController.text = "";
      });
    }
  }
}
