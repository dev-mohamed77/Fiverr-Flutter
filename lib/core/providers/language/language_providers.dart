import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final languages = [
  "English",
  "Arabic",
  "Hindi",
  "Indonesia",
  "French",
  "Spanish",
  "German",
  "Russian",
  "Chinese",
  "Italian",
  "Malay",
  "Bengali",
  "Portuguese",
  "Hausa",
  "Punjabi",
  "Japanese",
  "Persian",
];

class LanguageManager extends StateNotifier<List<String>> {
  LanguageManager(this.ref) : super(languages) {
    init();
  }

  final Ref ref;

  init() {
    final selectLanguage = ref.watch(selectLanguageProvider);

    if (selectLanguage != null) {
      List<String> lang = state;
      int index = lang.indexOf(selectLanguage);
      if (index > -1) {
        lang.removeAt(index);
        lang.insert(0, selectLanguage);

        state = lang;
      }
    }
  }

  searchLanguage(String letter) {
    state = state.where((element) {
      return element.toLowerCase().contains(letter);
    }).toList();
  }
}

final languageManagerProvider =
    StateNotifierProvider.autoDispose<LanguageManager, List<String>>((ref) {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(seconds: 10), () {
    link.close();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  return LanguageManager(ref);
});

final selectLanguageProvider = StateProvider<String?>((ref) {
  return null;
});
