import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileDataProvider = Provider(
  (ref) => [
    {
      "title": "Join Fiverr",
      "icon": Icons.add_circle_outline,
    },
    {
      "title": "Sign In",
      "icon": Icons.login_outlined,
    },
    {
      "title": "Become a seller",
      "icon": Icons.assessment_outlined,
    },
    {
      "title": "Saved lists",
      "icon": Icons.favorite_outline,
    },
    {
      "title": "Account",
      "icon": Icons.settings_outlined,
    },
    {
      "title": "Invite friends",
      "icon": Icons.near_me_outlined,
    },
    {
      "title": "Support",
      "icon": Icons.support_outlined,
    },
  ],
);
