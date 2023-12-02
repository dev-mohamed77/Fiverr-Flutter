import 'package:fiverr/features/my_list/presentation/pages/widgets/mylist_body.dart';
import 'package:flutter/material.dart';

class NyListScreen extends StatelessWidget {
  const NyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const MyListBody(),
    );
  }
}
