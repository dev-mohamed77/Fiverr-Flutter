// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:fiverr/core/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gigs/presentation/manager/providers.dart';
import 'package:fiverr/features/gigs/presentation/manager/select_category_and_sucategory_provider.dart';
import 'package:fiverr/features/gigs/presentation/manager/select_cover_image_picker_manager.dart';
import 'package:fiverr/features/gigs/presentation/manager/select_images_picker_manager.dart';
import 'package:fiverr/features/gigs/presentation/pages/create_gig/widgets/select_category_and_subcategory_section.dart';
import 'package:fiverr/features/gigs/presentation/pages/create_gig/widgets/select_cover_image_and_images_section.dart';

class CreateGigBody extends ConsumerStatefulWidget {
  const CreateGigBody({super.key});

  @override
  ConsumerState<CreateGigBody> createState() => _CreateGigBodyState();
}

class _CreateGigBodyState extends ConsumerState<CreateGigBody> {
  late ScrollController _scrollController;
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _deliveryTimeController;
  late TextEditingController _descriptionController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    _scrollController = ScrollController();
    _titleController = TextEditingController();
    _priceController = TextEditingController();
    _deliveryTimeController = TextEditingController();
    _descriptionController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _deliveryTimeController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      createGigUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "The gig has been successfully added",
              color: AppColor.primaryColor,
              gravity: ToastGravity.TOP,
            );

            ref.read(selectCoverImagePickerProvider.notifier).removeImagePick();
            ref.read(selectImagesPickerProvider.notifier).removeImagePick();
            ref
                .read(selectGigCategoryProvider.notifier)
                .update((state) => null);
            ref
                .read(selectGigSubCategoryProvider.notifier)
                .update((state) => null);
            context.pop();
            ref.read(getGigsBySellerIdUseCaseProvider.notifier).addGig(data!);
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(
              message: error.toString(),
              color: AppColor.redColor,
            );
          },
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpacer(15),
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, _) {
                        final createGig = ref.watch(createGigUseCaseProvider);
                        return LoadingLinearProgress(value: createGig);
                      },
                    ),
                    const VerticalSpacer(15),
                    TextFormFieldCustom(
                      label: "Title",
                      height: 70,
                      keyboardType: TextInputType.text,
                      controller: _titleController,
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return "Title is required";
                        }

                        return null;
                      },
                    ),
                    const VerticalSpacer(15),
                    TextFormFieldCustom(
                      label: "Price",
                      maxLength: 5,
                      height: 70,
                      keyboardType: TextInputType.number,
                      controller: _priceController,
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return "Price is required";
                        }

                        return null;
                      },
                    ),
                    const VerticalSpacer(15),
                    TextFormFieldCustom(
                      label: "Delivery Time",
                      maxLength: 5,
                      height: 70,
                      keyboardType: TextInputType.number,
                      controller: _deliveryTimeController,
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return "Delivery Time is required";
                        }

                        return null;
                      },
                    ),
                    const VerticalSpacer(15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Description"),
                        const VerticalSpacer(5),
                        TextFormFieldCustom(
                          keyboardType: TextInputType.multiline,
                          height: context.height * 0.2,
                          label: "",
                          maxLines: 10,
                          minLines: 6,
                          maxLength: 1000,
                          controller: _descriptionController,
                          validator: (data) {
                            if (data == null || data.isEmpty) {
                              return "Description is required";
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                    const VerticalSpacer(15),
                    const SelectCategoryAndSubCategorySection(),
                    const VerticalSpacer(15),
                    const SelectCoverImageAndImagesSection(),
                    const VerticalSpacer(15),
                  ],
                ),
              ),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final selectCoverImage =
                  ref.watch(selectCoverImagePickerProvider);
              final selectImages = ref.watch(selectImagesPickerProvider);
              final selectCategory = ref.watch(selectGigCategoryProvider);
              final selectSubCategory = ref.watch(selectGigSubCategoryProvider);
              return Container(
                width: context.width,
                height: 70,
                padding: const EdgeInsets.only(bottom: 13, top: 7),
                child: AppButton(
                  title: "Create Gig",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (selectCategory != null && selectSubCategory != null) {
                        if (selectCoverImage != null && selectImages != null) {
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                          ref.read(createGigUseCaseProvider.notifier).execute(
                                title: _titleController.text,
                                description: _descriptionController.text,
                                price: _priceController.text,
                                deliveryTime: _deliveryTimeController.text,
                                categoryId: selectCategory.id,
                                subCategoryId: selectSubCategory.id,
                                coverImage: File(selectCoverImage.path),
                                images: selectImages
                                    .map((e) => File(e.path))
                                    .toList(),
                              );
                        } else {
                          DialogCustom.showToast(
                              message: "Cover Image and Images are required",
                              color: AppColor.redColor);
                        }
                      } else {
                        DialogCustom.showToast(
                            message: "Category and SubCategory are required",
                            color: AppColor.redColor);
                      }
                    }
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
