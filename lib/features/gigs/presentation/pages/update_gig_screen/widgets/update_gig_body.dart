import 'package:dropdown_search/dropdown_search.dart';
import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/explore/domain/entity/category_entity.dart';
import 'package:fiverr/features/explore/presentation/manager/providers.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/gigs/presentation/manager/providers.dart';
import 'package:fiverr/features/gigs/presentation/manager/select_category_and_sucategory_provider.dart';
import 'package:fiverr/features/subcategory/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class UpdateGigBody extends ConsumerStatefulWidget {
  const UpdateGigBody({super.key, required this.gig});
  final GigEntity gig;

  @override
  ConsumerState<UpdateGigBody> createState() => _UpdateGigBodyState();
}

class _UpdateGigBodyState extends ConsumerState<UpdateGigBody> {
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _deliveryTimeController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _priceController = TextEditingController();
    _deliveryTimeController = TextEditingController();
    _descriptionController = TextEditingController();

    _titleController.text = widget.gig.title;
    _priceController.text = widget.gig.price.toString();
    _deliveryTimeController.text = widget.gig.deliveryTime.toString();
    _descriptionController.text = widget.gig.description;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _deliveryTimeController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(selectGigCategoryProvider);
    final subCategory = ref.watch(selectGigSubCategoryProvider);

    ref.listen(updateGigUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showToast(
            message: "Gig has been update successfully",
            color: AppColor.primaryColor,
            gravity: ToastGravity.TOP,
          );

          ref.read(getGigsBySellerIdUseCaseProvider.notifier).updateGig(data!);
          ref.read(selectGigCategoryProvider.notifier).update((state) => null);
          ref
              .read(selectGigSubCategoryProvider.notifier)
              .update((state) => null);

          context.pop();
        },
        error: (error, stack) {
          DialogCustom.showToast(
            message: error.toString(),
            color: AppColor.redColor,
            gravity: ToastGravity.TOP,
          );
        },
      );
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacer(15),
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, _) {
                      final updateGig = ref.watch(updateGigUseCaseProvider);
                      return LoadingLinearProgress(value: updateGig);
                    },
                  ),
                  const VerticalSpacer(15),
                  TextFormFieldCustom(
                    label: "Title",
                    height: 70,
                    keyboardType: TextInputType.text,
                    controller: _titleController,
                  ),
                  const VerticalSpacer(15),
                  TextFormFieldCustom(
                    label: "Price",
                    maxLength: 5,
                    height: 70,
                    keyboardType: TextInputType.number,
                    controller: _priceController,
                    onChanged: (value) {
                      _priceController.text = value;

                      print("Valuuuu ======${_priceController.text}");
                    },
                  ),
                  const VerticalSpacer(15),
                  TextFormFieldCustom(
                    label: "Delivery Time",
                    maxLength: 5,
                    height: 70,
                    keyboardType: TextInputType.number,
                    controller: _deliveryTimeController,
                  ),
                  const VerticalSpacer(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Description"),
                      const VerticalSpacer(5),
                      TextFormFieldCustom(
                        keyboardType: TextInputType.text,
                        height: context.height * 0.2,
                        label: "",
                        maxLines: 10,
                        minLines: 6,
                        maxLength: 1000,
                        controller: _descriptionController,
                      ),
                    ],
                  ),
                  const VerticalSpacer(15),
                  const UpdateGigSelectCategoryAndSubCategory(),
                  const VerticalSpacer(15),
                ],
              ),
            ),
          ),
          Container(
            width: context.width,
            height: 70,
            padding: const EdgeInsets.only(bottom: 13, top: 7),
            child: AppButton(
              title: "Update Gig",
              onPressed: () {
                ref.read(updateGigUseCaseProvider.notifier).execute(
                      widget.gig.id,
                      title: _titleController.text,
                      deliveryTime: _deliveryTimeController.text,
                      description: _descriptionController.text,
                      price: _priceController.text,
                      categoryId: category?.id,
                      subCategoryId: subCategory?.id,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UpdateGigButton extends ConsumerWidget {
  const UpdateGigButton({
    super.key,
    required this.gigId,
    required this.title,
    required this.description,
    required this.price,
    required this.deliveryTime,
  });
  final String gigId;
  final String title;
  final String description;
  final String price;
  final String deliveryTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

class UpdateGigSelectCategoryAndSubCategory extends ConsumerWidget {
  const UpdateGigSelectCategoryAndSubCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(getCategoriesUseCaseProvider);
    final subCategories =
        ref.watch(getSubCategoriesByCategoryIDUseCaseProvider);

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Category"),
            const VerticalSpacer(5),
            DropdownSearch<CategoryEntity>(
              items: categories.asData?.value ?? [],
              itemAsString: (item) {
                return item.name;
              },
              onChanged: (value) {
                ref
                    .read(getSubCategoriesByCategoryIDUseCaseProvider.notifier)
                    .execute(value!.id);
                ref
                    .read(selectGigCategoryProvider.notifier)
                    .update((state) => value);
              },
            ),
          ],
        ),
        const VerticalSpacer(15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("SubCategory"),
            const VerticalSpacer(5),
            DropdownSearch(
              items: subCategories.asData?.value ?? [],
              itemAsString: (item) {
                return item.name;
              },
              onChanged: (value) {
                ref
                    .read(selectGigSubCategoryProvider.notifier)
                    .update((state) => value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
