import 'package:dropdown_search/dropdown_search.dart';
import 'package:fiverr/core/components/horizontal_spacer.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/features/occupation/presentation/manager/occupation_manager.dart';
import 'package:fiverr/features/occupation/presentation/manager/select_occupation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddOccupationSection extends ConsumerStatefulWidget {
  const AddOccupationSection(
      {super.key, required this.specializationController});

  final TextEditingController specializationController;

  @override
  ConsumerState<AddOccupationSection> createState() =>
      _AddOccupationSectionState();
}

class _AddOccupationSectionState extends ConsumerState<AddOccupationSection> {
  Future<void> _selectFormDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      firstDate: DateTime(2000, 8),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        ref
            .read(selectOccupationFromProvider.notifier)
            .update((state) => value.toIso8601String());
      }
    });
  }

  Future<void> _selectToDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      firstDate: DateTime(2000, 8),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        ref
            .read(selectOccupationToProvider.notifier)
            .update((state) => value.toIso8601String());
      }
    });
  }

  late TextEditingController fromController;
  late TextEditingController toController;

  @override
  void initState() {
    fromController = TextEditingController();
    toController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    fromController.text = ref.watch(selectOccupationFromProvider) ?? "";
    toController.text = ref.watch(selectOccupationToProvider) ?? "";

    return Column(
      children: [
        DropdownSearch<String>(
          popupProps: const PopupProps.menu(
            showSelectedItems: true,
          ),
          items: occupationData,
          selectedItem: ref.watch(selectOccupationProvider) ?? "Occupations",
          onChanged: (value) {
            ref
                .read(selectOccupationProvider.notifier)
                .update((state) => value);
          },
        ),
        const VerticalSpacer(20),
        TextFormFieldCustom(
          height: 48,
          label: "specialization",
          controller: widget.specializationController,
          onChanged: (value) {
            ref
                .read(selectOccupationSpecializationProvider.notifier)
                .update((state) => value);
          },
        ),
        const VerticalSpacer(20),
        Row(
          children: [
            Expanded(
              child: TextFormFieldCustom(
                height: 48,
                label: "From",
                controller: fromController,
                onClick: () {
                  _selectFormDate(context);
                },
              ),
            ),
            const HorizontalSpacer(7),
            Expanded(
              child: TextFormFieldCustom(
                height: 48,
                label: "To",
                controller: toController,
                onClick: () {
                  _selectToDate(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
