import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  static LanguageController get to => Get.find();

  var locale = const Locale('en').obs;
  Map<String, String> _localizedStrings = {};

  @override
  void onInit() {
    super.onInit();
    loadPreferredLanguage();
  }

  Future<void> loadPreferredLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';
    await changeLanguage(languageCode, notify: false);
  }

  Future<void> changeLanguage(String languageCode, {bool notify = true}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);

    // Load the appropriate JSON file
    String jsonString = await rootBundle.loadString(
      'lib/language/lang/$languageCode.json',
    );
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Convert to Map<String, String>
    _localizedStrings = jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );

    // Update the locale
    locale(Locale(languageCode));

    // Trigger an update by calling refresh on the controller
    update();
  }

  String tr(String key) {
    return _localizedStrings[key] ?? key;
  }

  String getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ta':
        return 'தமிழ்';
      default:
        return 'English';
    }
  }

  String getCurrentLanguageName() {
    return getLanguageName(locale.value.languageCode);
  }
}
