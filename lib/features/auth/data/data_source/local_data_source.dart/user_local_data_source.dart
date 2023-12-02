import 'dart:developer';

import 'package:fiverr/core/service/local_service/local_key.dart';
import 'package:hive/hive.dart';

abstract class AuthLocalDataSource {
  String? getToken();

  Future<void> addToken(String token);
  Future<void> deleteToken();
}

class AuthLocalDataSourceImp implements AuthLocalDataSource {
  static late Box _hive;

  AuthLocalDataSourceImp._() {
    _hive = Hive.box(LocalHiveKey.authBox);
  }

  factory AuthLocalDataSourceImp() => AuthLocalDataSourceImp._();

  @override
  Future<void> addToken(String token) async {
    log("Response ================>> $token");
    _hive.put(LocalHiveKey.tokenKey, token);
  }

  @override
  String? getToken() {
    final token = _hive.get(LocalHiveKey.tokenKey);

    if (token != null) {
      return token;
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteToken() async {
    _hive.delete(LocalHiveKey.tokenKey);
  }
}
