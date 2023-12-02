import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/occupation/presentation/manager/providers.dart';
import 'package:fiverr/features/occupation/presentation/pages/widgets/occupation_body.dart';
import 'package:fiverr/features/skill/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class OccupationScreen extends StatelessWidget {
  const OccupationScreen({
    super.key,
    required this.sellerId,
    bool? isSellerPage,
  }) : _isSellerPage = isSellerPage ?? false;

  final String sellerId;
  final bool _isSellerPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Occupation",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: !_isSellerPage
            ? [
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, _) {
                    final sellerOccupations =
                        ref.watch(getOccupationBySellerIdUseCaseProvider);

                    return TextButtonCustom(
                      text: "Next",
                      onClick: () {
                        if (sellerOccupations.asData!.value!.isEmpty) {
                          DialogCustom.showToast(
                            message: "You must add at least one Occupation",
                            color: AppColor.redColor,
                            gravity: ToastGravity.TOP,
                          );
                        } else {
                          ref
                              .read(getSkillsBySellerIdUseCaseProvider.notifier)
                              .execute(sellerId: sellerId);
                          context.push(
                            Routes.sellerSkill,
                            extra: {
                              "sellerId": sellerId,
                              "isSellerPage": false,
                            },
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
      body: OccupationBody(
        sellerId: sellerId,
      ),
    );
  }
}
