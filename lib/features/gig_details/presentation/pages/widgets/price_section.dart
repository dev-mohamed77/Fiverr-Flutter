import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/gig_details/presentation/pages/widgets/container_custom.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({super.key, required this.gig});

  final GigEntity gig;

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "\$${gig.price}",
                style:
                    context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              const VerticalSpacer(10),
              Container(
                height: 2,
                width: context.width / 4,
                color: AppColor.primaryColor,
              ),
            ],
          ),
          const VerticalSpacer(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Delivery Days", style: context.bodyMedium!),
              Text(
                "3 Days",
                style:
                    context.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const VerticalSpacer(15),
          AppButton(
            title: "Continue (\$${gig.price})",
            onPressed: () {
              context.push(Routes.orderReview, extra: {
                "gig": gig,
                "sellerId": gig.seller.id,
              });
            },
          ),
        ],
      ),
    );
  }
}
