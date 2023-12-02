import 'package:fiverr/core/manager/router/global_navigator_key.dart';
import 'package:fiverr/core/manager/router/router_manager.dart';
import 'package:fiverr/core/manager/router/routes.dart';
import 'package:fiverr/core/providers/token/token_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);

  return GoRouter(
    initialLocation: token != null ? Routes.home : Routes.welcomeScreen,
    navigatorKey: rootNavigator,
    debugLogDiagnostics: true,
    routes: RouterManager.router(shellNavigator, ref),
  );
});
