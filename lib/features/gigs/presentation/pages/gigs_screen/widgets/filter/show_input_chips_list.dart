import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/text_button_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/extension/text_theme_extension.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';

class ShowInputChips extends StatelessWidget {
  const ShowInputChips({
    super.key,
    required this.items,
    required this.onClick,
    required this.select,
    required this.title,
  });

  final String title;
  final List<String> items;
  final String select;
  final void Function(bool) onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const VerticalSpacer(10),
        Wrap(
          children: items
              .expand((
                e,
              ) =>
                  [
                    InputChip(
                      label: Text(e),
                      showCheckmark: false,
                      onSelected: onClick,
                      selected: select == e.toString(),
                      selectedColor: AppColor.primaryColor.withOpacity(0.5),
                      side: BorderSide(
                        color: select == e.toString()
                            ? AppColor.primaryColor
                            : AppColor.blackColor,
                      ),
                      labelStyle: TextStyle(
                        color: select == e.toString()
                            ? AppColor.whiteColor
                            : AppColor.blackColor,
                      ),
                    ),
                    const HorizontalSpacer(10)
                  ])
              .toList(),
        ),
        if (items.length < 5) const VerticalSpacer(5),
        items.length < 5
            ? TextButtonCustom(
                text: "+${items.length - 5} more ...",
                onClick: () {},
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
