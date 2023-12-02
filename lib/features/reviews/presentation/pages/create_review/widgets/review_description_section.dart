import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/responsive_size_extensions.dart';
import 'package:fiverr/features/reviews/presentation/manager/select_add_review_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewDescriptionSection extends ConsumerWidget {
  const ReviewDescriptionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Description"),
        const VerticalSpacer(5),
        TextFormFieldCustom(
          keyboardType: TextInputType.text,
          height: context.height * 0.2,
          label: "",
          maxLines: 10,
          minLines: 6,
          maxLength: 1000,
          onChanged: (data) {
            ref
                .read(reviewDescriptionProvider.notifier)
                .update((state) => data);
          },
        ),
      ],
    );
  }
}
