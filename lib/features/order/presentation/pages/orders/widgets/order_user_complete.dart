import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/centered_message.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/features/order/presentation/managers/providers.dart';
import 'package:fiverr/features/order/presentation/pages/orders/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersUserComplete extends ConsumerWidget {
  const OrdersUserComplete({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(getOrderByUserIdUseCaseProvider);

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
              isShowButton: false,
              isCompleteUser: true,
            );
          },
          separatorBuilder: (context, index) {
            return const VerticalSpacer(10);
          },
          itemCount: data.result.length,
        );
      },
    );
  }
}
