import 'package:fiverr/features/seller/presentation/managers/image_picker_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final showButtonSellerAccountProvider = StreamProvider.autoDispose<bool>((ref) {
  final setImageSubject = BehaviorSubject<String?>();
  final setFullNameSubject = BehaviorSubject<String?>();
  final setDisplayNameSubject = BehaviorSubject<String?>();
  final setDescriptionSubject = BehaviorSubject<String?>();

  final image = ref.watch(imagePickerProvider);

  if (image != null) {
    setImageSubject.add(image.path);
  }

  final fullName = ref.watch(fullNameSellerProvider);
  if (fullName != null) {
    setFullNameSubject.add(fullName);
  }

  final displayName = ref.watch(displayNameSellerProvider);
  if (displayName != null) {
    setDisplayNameSubject.add(displayName);
  }

  final description = ref.watch(descriptionSellerProvider);
  if (description != null) {
    setDescriptionSubject.add(description);
  }

  final Stream<bool> isShowButton = Rx.combineLatest4(
    setImageSubject.startWith(null),
    setFullNameSubject.startWith(null),
    setDisplayNameSubject.startWith(null),
    setDescriptionSubject.startWith(null),
    (image, fullName, displayName, description) {
      if (image != null &&
          image.isNotEmpty &&
          fullName != null &&
          fullName.isNotEmpty &&
          displayName != null &&
          displayName.isNotEmpty &&
          description != null &&
          description.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    },
  );

  ref.onDispose(() {
    setImageSubject.close();
    setFullNameSubject.close();
    setDisplayNameSubject.close();
    setDescriptionSubject.close();
  });

  return isShowButton;
});

final fullNameSellerProvider = StateProvider<String?>((ref) => null);
final displayNameSellerProvider = StateProvider<String?>((ref) => null);
final descriptionSellerProvider = StateProvider<String?>((ref) => null);
