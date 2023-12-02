import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/order/domain/entity/order_entity.dart';
import 'package:fiverr/features/order/presentation/managers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.order,
    bool? isSeller,
    bool? isShowButton,
    bool? isCompleteUser,
  })  : _isSeller = isSeller ?? false,
        _isShowButton = isShowButton ?? true,
        _isCompleteUser = isCompleteUser ?? false;
  final OrderEntity order;
  final bool _isSeller;
  final bool _isShowButton;
  final bool _isCompleteUser;

  DateTime addDeliveryTimeToDateTime() {
    final now = DateTime.now();

    final date =
        DateTime(now.year, now.month, now.day + order.gig.deliveryTime);

    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      color: AppColor.whiteColor,
      surfaceTintColor: AppColor.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: context.width * 0.3,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          order.gig.coverImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const VerticalSpacer(10),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(order.seller.picture),
                        ),
                        const HorizontalSpacer(3),
                        Text(
                          order.seller.displayName,
                          style: context.titleSmall!
                              .copyWith(color: Colors.black54),
                        ),
                      ],
                    ),
                    const VerticalSpacer(10),
                    Text(
                      DateFormat.yMMMEd().format(addDeliveryTimeToDateTime()),
                      style: context.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                const HorizontalSpacer(3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$${order.subTotal}",
                        style: context.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const VerticalSpacer(15),
                      Text(
                        order.gig.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            context.titleSmall!.copyWith(color: Colors.black54),
                      ),
                      const VerticalSpacer(23),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Colors.black12.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: _isSeller
                                ? Text(
                                    order.statusSeller,
                                    style: context.titleSmall!.copyWith(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    order.statusUser,
                                    style: context.titleSmall!.copyWith(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                          const HorizontalSpacer(15),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (_isCompleteUser)
              Column(
                children: [
                  const VerticalSpacer(10),
                  SizedBox(
                    width: context.width,
                    child: AppButton(
                      title: "Add Review",
                      onPressed: () {
                        context.push(Routes.createReview, extra: order.gig.id);
                      },
                    ),
                  ),
                ],
              ),
            if (_isShowButton &&
                (order.statusUser == "on progress" ||
                    order.statusSeller == "on progress"))
              const VerticalSpacer(10),
            if (_isShowButton &&
                (order.statusUser == "on progress" ||
                    order.statusSeller == "on progress"))
              Consumer(
                builder: (BuildContext context, WidgetRef ref, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: context.width / 2.8,
                        child: AppButton(
                          color: AppColor.redColor,
                          title: "Cancel",
                          onPressed: () {
                            if (_isSeller) {
                              ref
                                  .read(
                                      updateStatusOrderUseCaseProvider.notifier)
                                  .execute(
                                      id: order.id, sellerStatus: "canceled");
                            } else {
                              ref
                                  .read(
                                      updateStatusOrderUseCaseProvider.notifier)
                                  .execute(
                                      id: order.id, userStatus: "canceled");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: context.width / 2.8,
                        child: AppButton(
                          title: "Complete",
                          onPressed: () {
                            if (_isSeller) {
                              ref
                                  .read(
                                      updateStatusOrderUseCaseProvider.notifier)
                                  .execute(
                                      id: order.id, sellerStatus: "complete");
                            } else {
                              ref
                                  .read(
                                      updateStatusOrderUseCaseProvider.notifier)
                                  .execute(
                                      id: order.id, userStatus: "complete");
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            if (_isShowButton &&
                (order.statusUser == "on progress" ||
                    order.statusSeller == "on progress"))
              const VerticalSpacer(10),
          ],
        ),
      ),
    );
  }
}
