import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountDataProvider = Provider(
  (ref) => [
    {"title": "Edit Account", "icon": Icons.manage_accounts_outlined},
    {"title": "Change Password", "icon": Icons.change_circle_outlined},
    {"title": "Logout", "icon": Icons.logout_outlined},
  ],
);
