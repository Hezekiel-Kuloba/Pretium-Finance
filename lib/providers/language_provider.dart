import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('en', '')) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'en';
    state = Locale(languageCode, '');
  }

  Future<void> changeLanguage(Locale locale) async {
    if (state != locale) {
      state = locale;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('languageCode', locale.languageCode);
    }
  }
}