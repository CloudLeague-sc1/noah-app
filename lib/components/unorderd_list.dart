import 'package:flutter/material.dart';
import 'package:noah/components/noah_rich_text.dart';
import '../models/domain/multilingual_string.dart';
import '../models/multilingual_text_util.dart';

class UnorderdList extends StatelessWidget {
  final List<MultilingualRichText> items;
  const UnorderdList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = items
        .map((e)=>UnorderdListItem(item: e,))
        .toList();
    return ListView(children: list);
  }
}

class UnorderdListItem extends StatelessWidget {
  final MultilingualRichText item;
  const UnorderdListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = NoahRichText(model: getLocaleRichText(item, context));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• "),
        Expanded(
          child: text,
        ),
      ],
    );
  }
}
