import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/order/presentation/managers/providers.dart';
import 'package:fiverr/features/order/presentation/managers/select_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OrderConfirmBody extends ConsumerStatefulWidget {
  const OrderConfirmBody({super.key});

  @override
  ConsumerState<OrderConfirmBody> createState() => _OrderConfirmBodyState();
}

class _OrderConfirmBodyState extends ConsumerState<OrderConfirmBody> {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _createOrderListen();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Submit Requirement to Start Your Order",
                    style: context.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const VerticalSpacer(15),
                  const Divider(),
                  const VerticalSpacer(5),
                  Text(
                    "The seller needs the following information to start working on your order:",
                    style: context.titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const VerticalSpacer(20),
                  Text(
                    "Do you have an Idea of what you want? or should I surprise you?",
                    style: context.titleMedium,
                  ),
                  const VerticalSpacer(35),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Description"),
                      const VerticalSpacer(5),
                      TextFormFieldCustom(
                        height: context.height * 0.2,
                        label: "",
                        maxLines: 10,
                        minLines: 4,
                        maxLength: 1000,
                        controller: _descriptionController,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: context.width,
            height: context.height * 0.103,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: AppButton(
              title: "Confirm Order",
              onPressed: () {
                ref.read(selectOrderProvider.notifier).update((state) =>
                    state?.copyWith(description: _descriptionController.text));

                final createOrder = ref.watch(selectOrderProvider);

                ref
                    .read(createOrderUseCaseProvider.notifier)
                    .execute(createOrder!);
              },
            ),
          )
        ],
      ),
    );
  }

  _createOrderListen() {
    ref.listen(createOrderUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showToast(
              message: "The order was created successfully",
              color: AppColor.primaryColor);

          context.go(Routes.order);

          ref.read(selectOrderProvider.notifier).update((state) => null);
        },
        error: (error, st) {
          DialogCustom.showToast(
            message: error.toString(),
            color: AppColor.redColor,
          );
        },
      );
    });
  }
}
