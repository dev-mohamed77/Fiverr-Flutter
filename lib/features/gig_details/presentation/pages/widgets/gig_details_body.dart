import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/features/gig_details/presentation/manager/provider.dart';
import 'package:fiverr/features/gig_details/presentation/pages/widgets/images_section.dart';
import 'package:fiverr/features/gig_details/presentation/pages/widgets/price_section.dart';
import 'package:fiverr/features/gig_details/presentation/pages/widgets/review_section.dart';
import 'package:fiverr/features/gig_details/presentation/pages/widgets/seller_section.dart';
import 'package:fiverr/features/gig_details/presentation/pages/widgets/title_and_description_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GigDetailsBody extends ConsumerWidget {
  const GigDetailsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gig = ref.watch(gigDetailsUseCaseProvider);

    return AsyncValueWidget(
      value: gig,
      data: (data) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ImagesSection(gigImage: data!.images),
              SellerSection(seller: data.seller),
              TitleAndDescriptionSection(
                title: data.title,
                description: data.description,
              ),
              const VerticalSpacer(20),
              PriceSection(gig: data),
              const VerticalSpacer(20),
              ReviewSection(gig: data),
            ],
          ),
        );
      },
    );
  }
}
