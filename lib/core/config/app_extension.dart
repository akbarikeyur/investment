// Create an extension on BuildContext
import 'package:flutter/material.dart';
import 'package:investment/core/localization/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  String localize(String key, {Map<String, String>? params}) {
    String translation = AppLocalizations.of(this).translate(key);

    if (params != null) {
      params.forEach((placeholder, value) {
        translation = translation.replaceAll('{$placeholder}', value);
      });
    }

    return translation;
  }
}
