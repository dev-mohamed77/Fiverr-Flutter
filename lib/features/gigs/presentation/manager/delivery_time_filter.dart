import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deliveryTimeFilterProvider = Provider(
  (ref) => [
    {
      "icon": Icons.history_toggle_off_outlined,
      "title": "24 Hours",
    },
    {
      "icon": Icons.calendar_month_outlined,
      "title": "3 Days",
    },
    {
      "icon": Icons.calendar_month_sharp,
      "title": "7 Days",
    },
  ],
);

final selectDeliveryTimeFilterProvider = StateProvider<String?>((ref) {
  return null;
});
