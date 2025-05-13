import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appLanguageProvider =
    StateNotifierProvider<AppLanguageNotifier, Locale>((ref) {
  return AppLanguageNotifier();
});

class AppLanguageNotifier extends StateNotifier<Locale> {
  AppLanguageNotifier() : super(const Locale('en', '')) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';
    state = Locale(languageCode);
  }

  Future<void> changeLanguage(Locale locale) async {
    if (state != locale) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', locale.languageCode);
      state = locale;
    }
  }
}
