import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/config/app_assets.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/features/nav_bar/presentation/manager/navbar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _customText(context, text: 'Fiverr'),
          const SizedBox(
            height: 15,
          ),
          _customText(context, text: 'FreeLance Service.\nOn Demand .'),
          const VerticalSpacer(10),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: context.height * 0.30,
              ),
              Container(
                height: context.height * 0.21,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(
                  bottom: 15,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButtonCustom(
                        text: "Sign In",
                        onClick: () {
                          context.push(Routes.signIn);
                        },
                      ),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          return TextButtonCustom(
                            text: "Skip",
                            onClick: () {
                              ref
                                  .read(navBarIndexProvider.notifier)
                                  .update((state) => 0);
                              context.go(Routes.home);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        context.push(Routes.auth);
                      },
                      child: _customContainer(
                        context,
                        image: AppAssets.serviceImage,
                        text: "Find a Service",
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: _customContainer(
                        context,
                        image: AppAssets.serviceImage,
                        text: "Become a seller",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _customText(
    BuildContext context, {
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: context.headlineMedium!.copyWith(
          color: Colors.white,
          height: 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _customContainer(
    BuildContext context, {
    required String text,
    required String image,
  }) {
    return Container(
      width: context.width / 2.3,
      height: context.height * 0.19,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.72,
                color: Colors.grey[200],
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Image.asset(image),
              ),
              Container(
                height: constraints.maxHeight * 0.28,
                alignment: Alignment.center,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: context.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
