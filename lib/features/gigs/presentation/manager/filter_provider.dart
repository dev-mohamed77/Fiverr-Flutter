import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterGigDataProvider =
    Provider<List<String>>((ref) => ["All", "Delivery Time", "Price"]);

final isSelectFilterProvider =
    StateProvider.autoDispose<String>((ref) => "Delivery Time");
