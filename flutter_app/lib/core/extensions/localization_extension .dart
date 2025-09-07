// Create a file: lib/extensions/localization_extension.dart
import 'package:droplet/core/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
