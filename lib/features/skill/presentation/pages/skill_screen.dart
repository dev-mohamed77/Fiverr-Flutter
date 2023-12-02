import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/skill/presentation/manager/providers.dart';
import 'package:fiverr/features/skill/presentation/pages/widgets/skill_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class SkillScreen extends StatelessWidget {
  const SkillScreen({super.key, required this.sellerId, bool? isSellerPage})
      : _isSellerPage = isSellerPage ?? false;

  final String sellerId;
  final bool _isSellerPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Skills",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: !_isSellerPage
            ? [
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, _) {
                    final skills =
                        ref.watch(getSkillsBySellerIdUseCaseProvider);

                    return TextButtonCustom(
                      text: "Next",
                      onClick: () {
                        if (skills.asData!.value!.isEmpty) {
                          DialogCustom.showToast(
                            message: "You must add at least one Skill",
                            color: AppColor.redColor,
                            gravity: ToastGravity.TOP,
                          );
                        } else {
                          context.go(
                            Routes.sellerAccount,
                            extra: true,
                          );
                        }
                      },
                    );
                  },
                ),
                const HorizontalSpacer(10),
              ]
            : [],
      ),
      body: SkillBody(
        sellerId: sellerId,
      ),
    );
  }
}
