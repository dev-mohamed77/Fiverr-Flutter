import 'package:fiverr/core/components/loading_linear_progress_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/features/order/presentation/managers/providers.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/order_seller_active.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/order_seller_canceled.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/order_seller_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellerOrderSection extends ConsumerStatefulWidget {
  const SellerOrderSection({
    super.key,
    required this.seller,
  });
  final SellerEntity seller;

  @override
  ConsumerState<SellerOrderSection> createState() => _SellerOrderSectionState();
}

class _SellerOrderSectionState extends ConsumerState<SellerOrderSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final updateOrderStatus = ref.watch(updateStatusOrderUseCaseProvider);
    return Column(
      children: [
        const VerticalSpacer(15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "The key to your success on Fiverr is the brand you build for yourself through your Fiverr reputation.",
            style: TextStyle(
              height: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const VerticalSpacer(10),
        LoadingLinearProgress(value: updateOrderStatus),
        const VerticalSpacer(10),
        TabBar(
          padding: const EdgeInsets.symmetric(vertical: 5),
          labelPadding: const EdgeInsets.symmetric(vertical: 10),
          indicatorColor: AppColor.primaryColor,
          controller: _tabController,
          onTap: (index) {
            if (user != null) {
              if (index == 0) {
                ref
                    .read(getOrderBySellerIdUseCaseProvider.notifier)
                    .execute(widget.seller.id, status: "on progress");
              } else if (index == 1) {
                ref
                    .read(getOrderBySellerIdUseCaseProvider.notifier)
                    .execute(widget.seller.id, status: "complete");
              } else {
                ref
                    .read(getOrderBySellerIdUseCaseProvider.notifier)
                    .execute(widget.seller.id, status: "canceled");
              }
            }
          },
          tabs: const [
            Text('Active'),
            Text('Complete'),
            Text("Canceled"),
          ],
        ),
        const VerticalSpacer(12),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: const [
              OrderSellerActive(),
              OrderSellerComplete(),
              OrderSellerCanceled(),
            ],
          ),
        ),
      ],
    );
  }
}
