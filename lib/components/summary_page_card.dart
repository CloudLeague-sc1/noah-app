import 'package:flutter/material.dart';
import '../models/domain/multilingual_string.dart';
import '../components/page_card.dart';
import 'unorderd_list.dart';

class SummaryPageCard extends PageCard {
  const SummaryPageCard({Key? key, required this.items}) : super(key: key);
  final List<MultilingualRichText> items;

  @override
  Widget build(BuildContext context) {
    return UnorderdList(items: items);
  }
}
