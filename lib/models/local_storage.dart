import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final storage = new FlutterSecureStorage();

  Future<String?> readData(String key) async {
    String? out = await storage.read(key: key);
    return out;
  }

  void writeData(String key, String value) async {
    await storage.write(key: key, value: value);
  }
}