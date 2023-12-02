import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/centered_message.dart';
import 'package:fiverr/features/order/presentation/managers/providers.dart';
import 'package:fiverr/features/order/presentation/pages/orders/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderSellerComplete extends ConsumerWidget {
  const OrderSellerComplete({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(getOrderBySellerIdUseCaseProvider);

    return AsyncValueWidget(
      value: orders,
      data: (data) {
        if (data.result.isEmpty) {
          return const CenteredMessage("No Orders Yet.");
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            final order = data.result[index];

            return OrderItem(
              order: order,
              isSeller: true,
              isShowButton: false,
            );
          },
          itemCount: data.result.length,
        );
      },
    );
  }
}
