import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/features/order/presentation/managers/providers.dart';
import 'package:fiverr/features/order/presentation/pages/orders/widgets/order_user_active.dart';
import 'package:fiverr/features/order/presentation/pages/orders/widgets/order_user_all.dart';
import 'package:fiverr/features/order/presentation/pages/orders/widgets/order_user_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final updateOrderStatus = ref.watch(updateStatusOrderUseCaseProvider);

    return Column(
      children: [
        const VerticalSpacer(5),
        LoadingLinearProgress(value: updateOrderStatus),
        const VerticalSpacer(5),
        TabBar(
          controller: _controller,
          padding: const EdgeInsets.symmetric(vertical: 5),
          labelPadding: const EdgeInsets.symmetric(vertical: 10),
          indicatorColor: AppColor.primaryColor,
          onTap: (index) {
            if (user != null) {
              if (index == 0) {
                ref
                    .read(getOrderByUserIdUseCaseProvider.notifier)
                    .execute(user.id);
              } else if (index == 1) {
                ref
                    .read(getOrderByUserIdUseCaseProvider.notifier)
                    .execute(user.id, status: "on progress");
              } else {
                ref
                    .read(getOrderByUserIdUseCaseProvider.notifier)
                    .execute(user.id, status: "complete");
              }
            }
          },
          tabs: [
            Text(
              "All",
              style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Active",
              style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Complete",
              style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TabBarView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                OrdersUserAll(),
                OrdersUserActive(),
                OrdersUserComplete(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
