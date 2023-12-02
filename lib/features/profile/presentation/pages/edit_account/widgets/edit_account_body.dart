import 'package:dropdown_search/dropdown_search.dart';
import 'package:fiverr/core/components/app_button.dart';
import 'package:fiverr/core/components/text_form_field_custom.dart';
import 'package:fiverr/core/components/vertical_spacer.dart';
import 'package:fiverr/core/manager/dialog/dialog_custom.dart';
import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:fiverr/core/providers/country/country_provider.dart';
import 'package:fiverr/core/providers/user/user_provider.dart';
import 'package:fiverr/features/profile/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditAccountBody extends ConsumerStatefulWidget {
  const EditAccountBody({super.key});

  @override
  ConsumerState<EditAccountBody> createState() => _EditAccountBodyState();
}

class _EditAccountBodyState extends ConsumerState<EditAccountBody> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController ageController;
  late TextEditingController genderController;
  late TextEditingController countryController;

  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    ageController = TextEditingController();
    genderController = TextEditingController();
    countryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    genderController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countries = ref.watch(countriesProvider);
    final user = ref.watch(userProvider);
    final updateUser = ref.watch(updateUserUseCase);

    ref.listen(updateUserUseCase, (previous, next) {
      next.maybeWhen(
        data: (data) {
          DialogCustom.showSnackBar(context, message: "Update User Success");
        },
        error: (error, stackTrace) {
          DialogCustom.showSnackBar(context,
              message: error.toString(), color: AppColor.redColor);
        },
        orElse: () {},
      );
    });

    nameController.text = user?.name ?? "";
    phoneController.text = user?.phone ?? "";
    ageController.text = user?.age.toString() ?? "";
    genderController.text = user?.gender ?? "";
    countryController.text = user?.country ?? "";

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpacer(20),
            updateUser.isLoading
                ? const Center(
                    child: LinearProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  )
                : const SizedBox.shrink(),
            const VerticalSpacer(30),
            TextFormFieldCustom(
              label: "Name",
              controller: nameController,
            ),
            const VerticalSpacer(40),

            TextFormFieldCustom(
              label: "Phone",
              controller: phoneController,
              keyboardType: TextInputType.number,
            ),
            const VerticalSpacer(40),
            TextFormFieldCustom(
              label: "Age",
              controller: ageController,
              keyboardType: TextInputType.number,
            ),
            const VerticalSpacer(30),
            // const TextFormFieldCustom(label: "Country"),
            const Text("Gender"),
            const VerticalSpacer(10),
            DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSelectedItems: true,
              ),
              items: const ["Male", "Female"],
              selectedItem: user?.gender,
              onChanged: (value) {
                genderController.text = value!;
              },
            ),
            const VerticalSpacer(30),
            const Text("Country"),
            const VerticalSpacer(10),
            DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSelectedItems: true,
              ),
              items: countries,
              selectedItem: user?.country,
              onChanged: (value) {
                countryController.text = value!;
              },
            ),

            const VerticalSpacer(30),
            AppButton(
              title: "Update Account",
              onPressed: () {
                ref.read(updateUserUseCase.notifier).execute(
                      name: nameController.text,
                      age: ageController.text.isEmpty
                          ? null
                          : int.parse(ageController.text),
                      country: countryController.text,
                      gender: genderController.text,
                      phone: phoneController.text,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
