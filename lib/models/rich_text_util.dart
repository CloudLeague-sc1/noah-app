import 'domain/rich_text.dart';

class RichTextStyle{
  bool isBold=false;
  bool isItalic=false;
  bool isUnderlined=false;
  bool isEmphasized=false;
  bool isStrikethrough=false;

  RichTextStyle.clear();
  RichTextStyle(this.isBold,this.isItalic,this.isEmphasized,this.isUnderlined,this.isStrikethrough);
  void applyDomainStyle(RichTextInner model){
      if(model is RichTextBold){
        isBold=true;
      }else if (model is RichTextItalic){
        isItalic = true;
      }else if(model is RichTextEm){
        isEmphasized = true;
      }else if(model is RichTextU){
        isUnderlined = true;
      }else if(model is RichTextS){
        isStrikethrough = true;
      }
  }

  RichTextStyle.from(RichTextStyle from){
    isBold = from.isBold;
    isItalic = from.isItalic;
    isEmphasized = from.isEmphasized;
    isUnderlined = from.isUnderlined;
    isStrikethrough = from.isStrikethrough;
  }
}

class RichTextSpan {
  final String text;
  final RichTextStyle style;
  RichTextSpan(this.text,this.style);
}

List<RichTextSpan> traverseRichText(RichText richText, RichTextStyle style){
  return richText.map((e)=> traverseRichTextInner(e,style)).expand((e) => e).toList();
}

List<RichTextSpan> traverseRichTextInner(RichTextInner model, RichTextStyle currentStyle){
  final style = RichTextStyle.from(currentStyle);
  style.applyDomainStyle(model);

  if(model is RichTextString){
    return [RichTextSpan(model.text,style)];
  }else if(model is RichTextBr){
    return [RichTextSpan('\n',style)];
  }
  return traverseRichText(model.inner,style);
}
