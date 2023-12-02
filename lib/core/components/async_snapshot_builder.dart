import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';

typedef AsyncSnapshotBuilderCallback<T> = Widget Function(
    BuildContext ctx, T? data);

class AsyncSnapshotStreamBuilder<T> extends StatelessWidget {
  const AsyncSnapshotStreamBuilder({
    super.key,
    this.onNone,
    this.onWaiting,
    this.onActive,
    this.onDone,
    required this.stream,
  });

  final Stream<T> stream;

  final AsyncSnapshotBuilderCallback<T>? onNone;
  final AsyncSnapshotBuilderCallback<T>? onWaiting;
  final AsyncSnapshotBuilderCallback<T>? onActive;
  final AsyncSnapshotBuilderCallback<T>? onDone;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            final callback = onNone ?? (_, __) => const SizedBox();
            return callback(context, snapshot.data);
          case ConnectionState.waiting:
            final callback = onWaiting ??
                (_, __) => const Center(
                        child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ));
            return callback(context, snapshot.data);
          case ConnectionState.active:
            final callback = onActive ?? (_, __) => const SizedBox();
            return callback(context, snapshot.data);
          case ConnectionState.done:
            final callback = onDone ?? (_, __) => const SizedBox();
            return callback(context, snapshot.data);
        }
      },
    );
  }
}
