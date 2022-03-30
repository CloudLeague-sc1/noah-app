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

  RichText getByLocale(String locale) {
    return locale.contains("ja") ? ja : en;
  }
}

RichTextInner parseRichText(dynamic json) {
  if (json is String) {
    return RichTextString(json);
  }

  final inner = json['inner'].map(parseRichText).toList().cast<RichTextInner>();

  switch (json['kind']) {
    case 'bold':
      return RichTextBold(inner);
    case 'italic':
      return RichTextItalic(inner);
    case 'em':
      return RichTextEm(inner);
    case 'br':
      return RichTextBr();
    case 'u':
      return RichTextU(inner);
    case 's':
      return RichTextS(inner);
    default:
      throw Exception('Unknown RichText kind: ${json['kind']}');
  }
}

class RichTextInner {
  RichText inner = [];
  RichTextInner(this.inner);
  RichTextInner.parse(dynamic json) {
    inner = json.map(parseRichText).toList();
  }
}

class RichTextString extends RichTextInner {
  String text = "";
  RichTextString(this.text) : super([]);
}

class RichTextBold extends RichTextInner {
  RichTextBold(RichText inner) : super(inner);
}

class RichTextItalic extends RichTextInner {
  RichTextItalic(RichText inner) : super(inner);
}

class RichTextEm extends RichTextInner {
  RichTextEm(RichText inner) : super(inner);
}

class RichTextBr extends RichTextInner {
  RichTextBr() : super([]);
}

class RichTextU extends RichTextInner {
  RichTextU(RichText inner) : super(inner);
}

class RichTextS extends RichTextInner {
  RichTextS(RichText inner) : super(inner);
}
