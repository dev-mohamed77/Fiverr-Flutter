import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/occupation/presentation/manager/providers.dart';
import 'package:fiverr/features/occupation/presentation/manager/select_occupation.dart';
import 'package:fiverr/features/occupation/presentation/pages/widgets/occupation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellerOccupationsSection extends ConsumerStatefulWidget {
  const SellerOccupationsSection({
    super.key,
  });

  @override
  ConsumerState<SellerOccupationsSection> createState() =>
      _SellerLanguagesSectionState();
}

class _SellerLanguagesSectionState
    extends ConsumerState<SellerOccupationsSection> {
  @override
  Widget build(BuildContext context) {
    final languages = ref.watch(getOccupationBySellerIdUseCaseProvider);
    ref.listen(deleteOccupationUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showToast(
            message: data!,
            color: AppColor.primaryColor,
            gravity: ToastGravity.TOP,
          );

          final occupation = ref.watch(selectDeleteOccupationProvider);

          if (occupation != null) {
            ref
                .read(getOccupationBySellerIdUseCaseProvider.notifier)
                .deleteOccupation(occupation);

            ref
                .read(selectDeleteOccupationProvider.notifier)
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
      value: languages,
      data: (data) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data!.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return OccupationItem(
              occupation: data[index],
            );
          },
        );
      },
    );
  }
}
