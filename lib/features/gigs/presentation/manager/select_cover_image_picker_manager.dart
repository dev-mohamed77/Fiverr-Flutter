import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class SelectCoverImagePickerManager extends StateNotifier<XFile?> {
  SelectCoverImagePickerManager() : super(null);

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

final selectCoverImagePickerProvider =
    StateNotifierProvider.autoDispose<SelectCoverImagePickerManager, XFile?>(
  (ref) => SelectCoverImagePickerManager(),
);
