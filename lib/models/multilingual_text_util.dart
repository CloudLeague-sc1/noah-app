import 'domain/multilingual_string.dart';
import 'package:flutter/material.dart';

String getLocaleText(MultilingualText model, BuildContext context) {
  return model.getByLocale(Localizations.localeOf(context).languageCode);
}
