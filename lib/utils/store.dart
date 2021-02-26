import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var tokenStorage = new FlutterSecureStorage();
String currentToken;

class Store {
  static setToken(token) async {
    await tokenStorage.write(key: "token", value: token);
    currentToken = token;
  }

  static getToken() async {
    if (currentToken != null) return currentToken;
    return await tokenStorage.read(key: "token");
  }

  static deleteToken() async {
    await tokenStorage.delete(key: "token");
  }
}
