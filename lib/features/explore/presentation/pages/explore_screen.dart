import 'package:fiverr/core/components/async_value.dart';
import 'package:fiverr/core/components/centered_message.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/features/explore/presentation/manager/providers.dart';
import 'package:fiverr/features/explore/presentation/pages/widgets/caregory_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          ref.read(getCategoriesUseCaseProvider.notifier).loadedMoreData();
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
  Widget build(
    BuildContext context,
  ) {
    final categories = ref.watch(getCategoriesUseCaseProvider);
    final getCategoriesNotifier =
        ref.watch(getCategoriesUseCaseProvider.notifier);

    return AsyncValueWidget(
      value: categories,
      data: (data) {
        if (data!.isEmpty) {
          return const CenteredMessage("No Category yet.");
        }
        return ListView.separated(
          controller: _scrollController,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            if (data.length == index) {
              if (!getCategoriesNotifier.noItemMore) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                );
              } else if (getCategoriesNotifier.noItemMore) {
                return const CenteredMessage('No more items');
              } else {
                return const SizedBox.shrink();
              }
            }

            final catData = data[index];
            return CategoryItem(category: catData);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const VerticalSpacer(10);
          },
        );
      },
    );
  }
}
