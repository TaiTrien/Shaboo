import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var store = new FlutterSecureStorage();
String currentToken;

class Store {
  static setToken(token) async {
    await store.write(key: "token", value: token);
    currentToken = token;
  }

  static getToken() async {
    // if (currentToken != null) return currentToken;
    return await store.read(key: "token");
  }

  static deleteToken() async {
    await store.delete(key: "token");
  }

  static setIsFirstTime(isFirstTime) async {
    await store.write(key: "isFirstTime", value: isFirstTime);
  }

  static getIsFirstTime() async {
    return await store.read(key: "isFirstTime");
  }

  static deleteIsFirstTime() async {
    await store.delete(key: "isFirstTime");
  }
}
