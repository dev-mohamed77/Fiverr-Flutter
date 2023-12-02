import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/features/seller/presentation/pages/create_seller/personal_info/widgets/personal_info_data.dart';
import 'package:fiverr/features/seller/presentation/pages/create_seller/personal_info/widgets/title_personal_info.dart';
import 'package:flutter/material.dart';

class PersonalInfoBody extends StatelessWidget {
  const PersonalInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            VerticalSpacer(20),
            TitlePersonalInfoSection(),
            VerticalSpacer(20),
            Divider(),
            VerticalSpacer(20),
            PersonalInfoDataSection()
          ],
        ),
      ),
    );
  }
}
