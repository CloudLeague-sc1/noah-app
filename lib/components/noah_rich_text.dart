import 'package:flutter/material.dart';
import '../models/rich_text_util.dart';
import '../models/domain/rich_text.dart' as dom_rich;

TextSpan renderRichTextSpan(RichTextSpan span) => TextSpan(
    text: span.text,
    style: TextStyle(
      fontWeight: span.style.isBold ? FontWeight.bold : null,
      fontStyle: span.style.isItalic ? FontStyle.italic : null,
      color: span.style.isEmphasized
          ? Colors.lightGreen
          : Colors.black, //TODO: Use course theme colour
      decoration: TextDecoration.combine([
        span.style.isUnderlined
            ? TextDecoration.underline
            : TextDecoration.none,
        span.style.isStrikethrough
            ? TextDecoration.lineThrough
            : TextDecoration.none
      ]),
    ));

class NoahRichText extends StatelessWidget {
  final dom_rich.RichText model;
  const NoahRichText({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: traverseRichText(model, RichTextStyle.clear())
            .map(renderRichTextSpan)
            .toList(),
      ),
    );
  }
}
