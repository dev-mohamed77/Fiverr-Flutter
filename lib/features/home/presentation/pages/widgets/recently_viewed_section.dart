import 'package:fiverr/core/components/gig_vertical_item.dart';
import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/service/local_service/local_key.dart';
import 'package:fiverr/features/gig_details/data/model/gig_local_model.dart';
import 'package:fiverr/features/home/presentation/pages/widgets/title_section.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RecentlyViewedSection extends StatelessWidget {
  const RecentlyViewedSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleSection(title: "Recently viewed Gigs"),
        const VerticalSpacer(5),
        ValueListenableBuilder(
          valueListenable:
              Hive.box<GigLocalModel>(LocalHiveKey.gigs).listenable(),
          builder: (BuildContext context, value, _) {
            final data = value.values.toSet().toList().reversed.toList();
            return SizedBox(
              width: context.width,
              height: context.height * 0.315,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 5,
                  bottom: 5,
                  right: 10,
                ),
                itemBuilder: (context, index) {
                  // final data = value.getAt(index);
                  return GigVerticalItm(
                    id: data[index].id,
                    title: data[index].title,
                    price: data[index].price,
                    image: data[index].image,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const HorizontalSpacer(15);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
