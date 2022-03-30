import 'package:flutter/material.dart';
import '../models/domain/page.dart';
import '../models/multilingual_text_util.dart';
import '../components/page_card.dart';
import 'noah_rich_text.dart';
import '../models/domain/media.dart';
import 'media.dart';

class ContentPageCard extends PageCard {
  final Content page;
  const ContentPageCard({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final contents = <Widget>[];
    contents.add(NoahRichText(model: getLocaleRichText(page.text, context)));

    final mediaModel = page.media;
    if(mediaModel is Media){
      contents.add(renderMedia(mediaModel));
    }

    return Column(
      children: contents,
    );
  }
}
