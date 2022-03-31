import 'domain/multilingual_string.dart' as noah_i18n;
import 'package:flutter/material.dart';

String getLocaleText(noah_i18n.MultilingualText model, BuildContext context) {
  return model.getByLocale(Localizations.localeOf(context).languageCode);
}

noah_i18n.RichText getLocaleRichText(
    noah_i18n.MultilingualRichText model, BuildContext context) {
  return model.getByLocale(Localizations.localeOf(context).languageCode);
}
