import 'package:flutter/material.dart';
import 'package:noah/components/noah_rich_text.dart';
import 'package:noah/models/multilingual_text_util.dart';
import '../models/domain/multilingual_string.dart';
import '../models/domain/annotation.dart';

enum AnnotationType { note, warn }

abstract class AnnotationBox extends StatelessWidget {
  final AnnotationType type;
  final MultilingualRichText text;
  const AnnotationBox({Key? key, required this.type, required this.text})
      : super(key: key);

  Color getBorderColor() {
    switch (type) {
      case AnnotationType.note:
        return Colors.blue.shade800;
      case AnnotationType.warn:
        return Colors.yellow.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top:16),
            padding: const EdgeInsets.all(16.0),
            child: NoahRichText(model: getLocaleRichText(text, context)),
            decoration: BoxDecoration(
              border: Border.all(color: getBorderColor()),
              borderRadius: BorderRadius.circular(10),
            ))
      ]),
    );
  }
}

class NoteAnnotationBox extends AnnotationBox {
  const NoteAnnotationBox({Key? key, required MultilingualRichText text})
      : super(key: key, type: AnnotationType.note, text: text);
}

class WarnAnnotationBox extends AnnotationBox {
  const WarnAnnotationBox({Key? key, required MultilingualRichText text})
      : super(key: key, type: AnnotationType.warn, text: text);
}

AnnotationBox renderAnnotation(Annotation model) {
  if (model is WarnAnnotation) {
    return WarnAnnotationBox(text: model.text);
  } else if (model is NoteAnnotation) {
    return NoteAnnotationBox(text: model.text);
  }

  throw Exception("renderAnnotation: unknown annotation type");
}
