import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/centered_message.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/order/presentation/managers/providers.dart';
import 'package:fiverr/features/order/presentation/pages/orders/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersUserAll extends ConsumerWidget {
  const OrdersUserAll({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(getOrderByUserIdUseCaseProvider);

    ref.listen(
      updateStatusOrderUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
                message: "The request was completed successfully",
                color: AppColor.primaryColor);

            ref
                .read(getOrderByUserIdUseCaseProvider.notifier)
                .removeOrder(data!);
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(
                message: error.toString(), color: AppColor.redColor);
          },
        );
      },
    );

    return AsyncValueWidget(
      value: orders,
      data: (data) {
        if (data.result.isEmpty) {
          return const CenteredMessage("No Order Yet.");
        }

        return ListView.separated(
          itemBuilder: (context, index) {
            return OrderItem(
              order: data.result[index],
            );
          },
          separatorBuilder: (context, index) {
            return const VerticalSpacer(10);
          },
          itemCount: data.length,
        );
      },
    );
  }
}
