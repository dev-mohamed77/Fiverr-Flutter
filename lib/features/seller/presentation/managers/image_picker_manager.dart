import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerManager extends StateNotifier<XFile?> {
  ImagePickerManager() : super(null);

  void addImage(ImageSource source) async {
    final img = await ImagePicker().pickImage(source: source);

    if (img != null) {
      state = img;
    }
  }

  void removeImagePick() {
    state = null;
  }
}

final imagePickerProvider =
    StateNotifierProvider.autoDispose<ImagePickerManager, XFile?>(
  (ref) => ImagePickerManager(),
);
