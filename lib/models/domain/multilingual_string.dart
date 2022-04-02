import 'rich_text.dart';

class MultilingualText {
  MultilingualText(this.ja, this.en);
  String ja = "";
  String en = "";
  MultilingualText.fromJson(Map<String, dynamic> json) {
    if (json['ja'] is Map || json['ja'] is List) {
      throw Exception('Multilingual String Error: ja is not string-ish');
    }

    if (json['ja'] is Map || json['ja'] is List) {
      throw Exception('Multilingual String Error: en is not string-ish');
    }

    ja = json['ja'].toString();
    en = json['en'].toString();
  }
  Map<String, dynamic> toJson() => {
    'ja': ja,
    'en': en,
  };
  MultilingualText.empty();

  String getByLocale(String locale) {
    return locale.contains("ja") ? ja : en;
  }
}

typedef RichText = List<RichTextInner>;

class MultilingualRichText {
  RichText ja = [];
  RichText en = [];
  MultilingualRichText(this.ja, this.en);
  MultilingualRichText.empty() {
    ja = [];
    en = [];
  }
  MultilingualRichText.fromJson(Map<String, dynamic> json) {
    ja = json['ja'].map(parseRichText).toList().cast<RichTextInner>();
    en = json['en'].map(parseRichText).toList().cast<RichTextInner>();
  }

  getByLocale(String locale) {
    return locale.contains("ja") ? ja : en;
  }
}
