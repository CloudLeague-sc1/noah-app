typedef RichText = List<RichTextInner>;
class RichTextInner {
  RichText inner = [];
  RichTextInner(this.inner);
  RichTextInner.parse(dynamic json) {
    inner = json.map(parseRichText).toList();
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
