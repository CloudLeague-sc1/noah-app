import 'package:flutter/material.dart';
import '../models/domain/page.dart';
import '../models/multilingual_text_util.dart';
import '../components/page_card.dart';

class ContentPageCard extends PageCard {
  final Content page;
  const ContentPageCard({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(getLocaleRichText(page.text, context).toString()),
    );
  }
}
