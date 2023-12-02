import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/occupation/presentation/manager/providers.dart';
import 'package:fiverr/features/occupation/presentation/manager/select_occupation.dart';
import 'package:fiverr/features/occupation/presentation/pages/widgets/add_occupation_section.dart';
import 'package:fiverr/features/occupation/presentation/pages/widgets/get_occupation_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OccupationBody extends ConsumerStatefulWidget {
  const OccupationBody({super.key, required this.sellerId});

  final String sellerId;

  @override
  ConsumerState<OccupationBody> createState() => _OccupationBodyState();
}

class _OccupationBodyState extends ConsumerState<OccupationBody> {
  late TextEditingController specializationController;

  @override
  void initState() {
    specializationController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    specializationController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final createOccupation = ref.watch(createOccupationUseCaseProvider);
    _createOccupationListen(ref, context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const VerticalSpacer(15),
                  LoadingLinearProgress(value: createOccupation),
                  const VerticalSpacer(15),
                  AddOccupationSection(
                    specializationController: specializationController,
                  ),
                  const VerticalSpacer(30),
                  const Divider(),
                  const VerticalSpacer(20),
                  const SellerOccupationsSection(),
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
                  title: "Add Occupation",
                  onPressed: () {
                    _createLanguage(ref);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _createOccupationListen(WidgetRef ref, BuildContext ctx) {
    ref.listen(
      createOccupationUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "The language has been created successfully",
              color: AppColor.primaryColor,
              gravity: ToastGravity.TOP,
            );
            ref.read(selectOccupationProvider.notifier).update((state) => null);
            ref
                .read(selectOccupationSpecializationProvider.notifier)
                .update((state) => null);
            ref
                .read(selectOccupationFromProvider.notifier)
                .update((state) => null);
            ref
                .read(selectOccupationToProvider.notifier)
                .update((state) => null);
            ref
                .read(getOccupationBySellerIdUseCaseProvider.notifier)
                .addOccupation(data!);
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

  _createLanguage(WidgetRef ref) {
    final occupation = ref.watch(selectOccupationProvider);
    final specialization = ref.watch(selectOccupationSpecializationProvider);
    final from = ref.watch(selectOccupationFromProvider);
    final to = ref.watch(selectOccupationToProvider);

    if (occupation == null ||
        specialization == null ||
        from == null ||
        to == null) {
      DialogCustom.showToast(
        message: "You must choose the Occupation, specialization, form, and To",
        color: AppColor.redColor,
        gravity: ToastGravity.TOP,
      );
    } else {
      ref.read(createOccupationUseCaseProvider.notifier).execute(
            sellerId: widget.sellerId,
            specialization: specialization,
            occupation: occupation,
            from: from,
            to: to,
          );
      specializationController.text = "";
    }
  }
}
