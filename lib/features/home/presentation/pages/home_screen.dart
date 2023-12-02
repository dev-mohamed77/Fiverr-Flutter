import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/gig_vertical_item.dart';
import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/features/gigs/presentation/manager/providers.dart';
import 'package:fiverr/features/home/presentation/pages/widgets/popular_service_section.dart';
import 'package:fiverr/features/home/presentation/pages/widgets/recently_viewed_section.dart';
import 'package:fiverr/features/home/presentation/pages/widgets/search_section.dart';
import 'package:fiverr/features/home/presentation/pages/widgets/title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          VerticalSpacer(10),
          SearchSection(),
          VerticalSpacer(50),
          PopularServiceSection(),
          VerticalSpacer(30),
          ProgrammingTechSection(),
          VerticalSpacer(30),
          RecentlyViewedSection(),
          VerticalSpacer(20),
        ],
      ),
    );
  }
}

class ProgrammingTechSection extends StatelessWidget {
  const ProgrammingTechSection({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: [
        const TitleSection(title: "Programming & Tech Gigs"),
        const VerticalSpacer(5),
        SizedBox(
          width: context.width,
          height: context.height * 0.315,
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, _) {
              final gigs = ref.watch(getGigsByCategoryIdUseCaseProvider);

              return AsyncValueWidget(
                value: gigs,
                data: (data) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: data!.length,
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 5,
                      bottom: 5,
                      right: 10,
                    ),
                    itemBuilder: (context, index) {
                      return GigVerticalItm(
                        id: data[index].id,
                        title: data[index].title,
                        price: data[index].price,
                        image: data[index].coverImage,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const HorizontalSpacer(15);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
