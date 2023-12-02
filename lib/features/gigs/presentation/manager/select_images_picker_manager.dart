import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class SelectImagesPickerManager extends StateNotifier<List<XFile>?> {
  SelectImagesPickerManager() : super(null);

  void addImages() async {
    final img = await ImagePicker().pickMultiImage();

    state = img;
  }

  void removeImagePick() {
    state = null;
  }
}

final selectImagesPickerProvider =
    StateNotifierProvider.autoDispose<SelectImagesPickerManager, List<XFile>?>(
  (ref) => SelectImagesPickerManager(),
);
