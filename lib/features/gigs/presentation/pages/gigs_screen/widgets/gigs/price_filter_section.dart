import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/async_snapshot_builder.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/app_manager/show_button_by_two_text_field.dart';
import 'package:fiverr/features/gigs/presentation/manager/providers.dart';
import 'package:fiverr/features/subcategory/presentation/manager/select_subcategory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceFilterSection extends ConsumerStatefulWidget {
  const PriceFilterSection({
    required this.height,
    required this.width,
    super.key,
  });

  final double height;
  final double width;

  @override
  ConsumerState<PriceFilterSection> createState() => _PriceFilterSectionState();
}

class _PriceFilterSectionState extends ConsumerState<PriceFilterSection> {
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;
  late ShowButtonByTwoTextField showButton;

  @override
  void initState() {
    minPriceController = TextEditingController();
    maxPriceController = TextEditingController();
    showButton = ShowButtonByTwoTextField();
    super.initState();
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    showButton.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final suCategory = ref.watch(selectSubCategoryProvider);

    return SizedBox(
      width: context.width,
      height: widget.height * 0.81,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const VerticalSpacer(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Min Price",
                      style: context.bodySmall,
                    ),
                    Text(
                      "Max Price",
                      style: context.bodySmall,
                    ),
                  ],
                ),
                const VerticalSpacer(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: context.width / 2.25,
                      height: constraints.maxHeight * 0.285,
                      child: TextFormFieldCustom(
                        label: '',
                        controller: minPriceController,
                        keyboardType: TextInputType.number,
                        onChanged: (data) => showButton.setTextField1.add(data),
                      ),
                    ),
                    SizedBox(
                      width: context.width / 2.25,
                      height: constraints.maxHeight * 0.285,
                      child: TextFormFieldCustom(
                        label: '',
                        controller: maxPriceController,
                        onChanged: (data) => showButton.setTextField2.add(data),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const VerticalSpacer(10),
                AsyncSnapshotStreamBuilder(
                  stream: showButton.isShowButton,
                  onActive: (context, data) {
                    final isShow = data ?? false;
                    return AppButton(
                      title: 'Send',
                      height: constraints.maxHeight * 0.253,
                      onPressed: isShow
                          ? () {
                              ref
                                  .read(getGigsBySubCategoryIdUseCaseProvider
                                      .notifier)
                                  .execute(
                                    suCategory?.id ?? "",
                                    minPrice: minPriceController.text,
                                    maxPrice: maxPriceController.text,
                                  );
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
