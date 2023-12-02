import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/features/gigs/presentation/manager/providers.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/widgets/gigs/filter_gig_section.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/widgets/gigs/gigs_section.dart';
import 'package:fiverr/features/gigs/presentation/pages/gigs_screen/widgets/gigs/subcategory_title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GigsBody extends ConsumerStatefulWidget {
  const GigsBody({super.key});

  @override
  ConsumerState<GigsBody> createState() => _GigsBodyState();
}

class _GigsBodyState extends ConsumerState<GigsBody> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          ref
              .read(getGigsBySubCategoryIdUseCaseProvider.notifier)
              .loadedMoreData();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          VerticalSpacer(15),
          SubCategoryTitleSection(),
          VerticalSpacer(30),
          FilterGigWidget(),
          VerticalSpacer(30),
          GigsSection(),
        ],
      ),
    );
  }
}
