import 'dart:async';

import 'package:fiverr/app.dart';
import 'package:fiverr/core/providers/token/token_provider.dart';
import 'package:fiverr/core/service/local_service/local_key.dart';
import 'package:fiverr/core/service/web_socket/web_socket_manager.dart';
import 'package:fiverr/features/auth/data/data_source/local_data_source.dart/provider.dart';
import 'package:fiverr/features/gig_details/data/model/gig_local_model.dart';
import 'package:fiverr/features/profile/presentation/manager/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppManager {
  AppManager._();

  static Future<void> init() async {
    runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        stripePublishKey();

        final container = ProviderContainer();

        await _init();
        _getToken(container);
        _initWebSocket(container);
        runApp(
          UncontrolledProviderScope(
            container: container,
            child: const MyApp(),
          ),
        );
      },
      (error, stack) {},
    );
  }

  static stripePublishKey() async {
    Stripe.publishableKey =
        "pk_test_51O9UqWK5xVreaiezERbamnbBzR1jpNlzYMcYnOrvoCcUoYpMzut29KT4NQbUvpoxWYAjmldltzLjAs2ZkPO8bK8T00wlK4FMeC";
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
    Stripe.urlScheme = 'flutterstripe';
    await Stripe.instance.applySettings();
  }

  static Future<void> _init() async {
    // final document = await getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    // Hive.init(document.path);
    Hive.registerAdapter(GigLocalModelAdapter());
    await Hive.openBox(LocalHiveKey.authBox);
    await Hive.openBox<GigLocalModel>(LocalHiveKey.gigs);
  }

  static void _getToken(ProviderContainer ref) async {
    final token = ref.read(authLocalDataSourceProvider).getToken();

    if (token != null) {
      ref.read(tokenProvider.notifier).update((state) => token);
      ref.read(userGetMeUseCase.notifier).execute();
    } else {
      ref.read(tokenProvider.notifier).update((state) => null);
    }
  }

  static void _initWebSocket(ProviderContainer ref) {
    ref.read(webSocketManagerProvider);
  }
}
