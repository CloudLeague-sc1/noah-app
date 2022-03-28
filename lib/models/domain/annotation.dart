import 'multilingual_string.dart';

enum AnnotationType { note, warn }

class Annotation {
  AnnotationType type = AnnotationType.note;
  MultilingualRichText text = MultilingualRichText.empty();
  Annotation(this.type, this.text);
}

class NoteAnnotation extends Annotation {
  NoteAnnotation(MultilingualRichText text) : super(AnnotationType.note, text);
}

class WarnAnnotation extends Annotation {
  WarnAnnotation(MultilingualRichText text) : super(AnnotationType.warn, text);
}

Annotation parseAnnotation(Map<String, dynamic> json) {
  if (json['type'] is! String) {
    throw Exception("Annotation type is not string");
  }

  final type = json['type'];
  switch (type) {
    case 'note':
      return NoteAnnotation(MultilingualRichText.fromJson(json['text']));
    case 'warn':
      return WarnAnnotation(MultilingualRichText.fromJson(json['text']));
    default:
      throw Exception("Unknown annotation type `$type`");
  }
}
