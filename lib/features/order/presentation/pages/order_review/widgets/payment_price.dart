import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentPrice extends StatelessWidget {
  const PaymentPrice({super.key, required this.gig});

  final GigEntity gig;

  DateTime addDeliveryTimeToDateTime() {
    final now = DateTime.now();

    final date = DateTime(now.year, now.month, now.day + gig.deliveryTime);

    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order summary",
          style: context.titleLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 19),
        ),
        const VerticalSpacer(10),
        ListTile(
          title: Text(
            "Subtotal",
            style: context.titleSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            "\$${gig.price}",
            style: context.titleSmall!,
          ),
        ),
        const VerticalSpacer(7),
        ListTile(
          title: Text(
            "Service Fee",
            style: context.titleSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            "\$${gig.price * 0.025}",
            style: context.titleSmall!,
          ),
        ),
        const VerticalSpacer(10),
        const Divider(),
        const VerticalSpacer(10),
        ListTile(
          title: Text(
            "Total",
            style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            "\$${gig.price + (gig.price * 0.025)}",
            style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const VerticalSpacer(7),
        ListTile(
          title: Text(
            "Delivery Date",
            style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            DateFormat.yMMMEd().format(addDeliveryTimeToDateTime()),
            style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
