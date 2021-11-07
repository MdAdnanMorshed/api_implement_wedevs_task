import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStoreToken {
  static LocalStoreToken object = LocalStoreToken._();

  LocalStoreToken._();

  init() async {
    await GetStorage.init(DbStrings.db_name);
  }

  String getToken() {
    GetStorage db = GetStorage(DbStrings.db_name);
    String token = db.read(
      DbStrings.user_token,
    );
    return token;
  }

  Future<void> setToken(String token) async {
    GetStorage db = GetStorage(DbStrings.db_name);
    await db.write(DbStrings.user_token, token);
    await db.save();
  }

}

class DbStrings {
  static const db_name = 'local_save';
  static const user_token = 'user_token';

}