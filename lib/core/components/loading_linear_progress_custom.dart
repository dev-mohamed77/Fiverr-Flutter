import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingLinearProgress<T> extends StatelessWidget {
  const LoadingLinearProgress({super.key, required this.value});
  final AsyncValue<T> value;

  @override
  Widget build(BuildContext context) {
    return value.isLoading
        ? const LinearProgressIndicator(
            color: AppColor.primaryColor,
          )
        : const SizedBox.shrink();
  }
}
