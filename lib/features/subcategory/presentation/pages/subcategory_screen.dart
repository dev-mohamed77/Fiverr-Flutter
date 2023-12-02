import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/features/subcategory/presentation/manager/providers.dart';
import 'package:fiverr/features/subcategory/presentation/pages/widgets/subcategories_items.dart';
import 'package:fiverr/features/subcategory/presentation/pages/widgets/subcategory_title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategoryScreen extends ConsumerStatefulWidget {
  const SubCategoryScreen({super.key});

  @override
  ConsumerState<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends ConsumerState<SubCategoryScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          ref
              .read(getSubCategoriesByCategoryIDUseCaseProvider.notifier)
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
    return SingleChildScrollView(
      controller: _scrollController,
      child: const Column(
        children: [
          VerticalSpacer(20),
          CategoryTitleSection(),
          VerticalSpacer(20),
          SubCategoryItems(),
        ],
      ),
    );
  }
}
