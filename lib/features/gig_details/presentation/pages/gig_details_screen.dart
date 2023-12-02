import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/features/gig_details/presentation/manager/provider.dart';
import 'package:fiverr/features/gig_details/presentation/pages/widgets/gig_details_body.dart';
import 'package:fiverr/features/inbox/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GigDetailsScreen extends StatelessWidget {
  const GigDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: AppColor.whiteColor,
        backgroundColor: Colors.transparent,
      ),
      body: const GigDetailsBody(),
      floatingActionButton: Consumer(
        builder: (BuildContext context, WidgetRef ref, _) {
          final gig = ref.watch(gigDetailsUseCaseProvider);
          final user = ref.watch(userProvider);
          return FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 241, 240, 240),
            onPressed: () {
              ref
                  .read(getConversationByUserIdAndSellerIdUseCase.notifier)
                  .execute(
                    sellerID: gig.value?.seller.id ?? "",
                    userID: user?.id ?? "",
                  );
              context.push(Routes.chat, extra: {
                "sellerId": gig.value?.seller.id,
                "sender": "user",
              });
            },
            child: const Icon(
              Icons.chat,
              color: AppColor.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
