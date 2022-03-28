import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<String> loadAsset(String name) async {
  return await rootBundle.loadString(name);
}

Future<dynamic> loadJsonAsset(String name) async {
  final assetString = await loadAsset(name);
  return jsonDecode(assetString);
}
