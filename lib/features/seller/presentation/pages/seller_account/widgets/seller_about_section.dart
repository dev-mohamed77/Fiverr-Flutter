import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/features/language/presentation/manager/providers.dart';
import 'package:fiverr/features/occupation/presentation/manager/providers.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/seller_description_section.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/seller_features_section.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/seller_image_and_name_section.dart';
import 'package:fiverr/features/seller/presentation/pages/seller_account/widgets/website_section.dart';
import 'package:fiverr/features/skill/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SellerAboutSection extends ConsumerWidget {
  const SellerAboutSection({super.key, required this.data});

  final SellerEntity data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
      child: Column(
        children: [
          const VerticalSpacer(30),
          SellerImageAndNameSection(
            data: data,
          ),
          const VerticalSpacer(12),
          const Divider(),
          SellerDescriptionSection(data: data),
          const VerticalSpacer(12),
          const Divider(),
          const VerticalSpacer(15),
          SellerFeaturesSection<SellerOccupationEntity>(
            list: data.occupation,
            title: "Occupation",
            data: data,
            onClick: () {
              ref
                  .read(getOccupationBySellerIdUseCaseProvider.notifier)
                  .execute(sellerId: data.id);
              context.push(
                Routes.sellerOccupation,
                extra: {
                  "sellerId": data.id,
                  "isSellerPage": true,
                },
              );
            },
          ),
          const VerticalSpacer(12),
          const Divider(),
          const VerticalSpacer(15),
          SellerFeaturesSection<SellerLanguageEntity>(
            list: data.language,
            title: "Languages",
            data: data,
            onClick: () {
              ref
                  .read(getLanguageBySellerIdUseCaseProvider.notifier)
                  .execute(sellerId: data.id);
              ref.context.push(
                Routes.sellerLanguage,
                extra: {
                  "sellerId": data.id,
                  "isSellerPage": true,
                },
              );
            },
          ),
          const VerticalSpacer(12),
          const Divider(),
          const VerticalSpacer(15),
          SellerFeaturesSection<SellerSkillEntity>(
            list: data.skills,
            title: "Skills",
            data: data,
            onClick: () {
              ref
                  .read(getSkillsBySellerIdUseCaseProvider.notifier)
                  .execute(sellerId: data.id);
              context.push(
                Routes.sellerSkill,
                extra: {
                  "sellerId": data.id,
                  "isSellerPage": true,
                },
              );
            },
          ),
          const VerticalSpacer(12),
          const Divider(),
          const VerticalSpacer(15),
          WebsiteSection(data: data),
          const VerticalSpacer(12),
          const Divider(),
          const VerticalSpacer(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Balance",
                style:
                    context.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${data.balance}",
                style:
                    context.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const VerticalSpacer(15),
        ],
      ),
    );
  }
}
