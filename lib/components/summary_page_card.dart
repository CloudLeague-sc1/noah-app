import 'package:flutter/material.dart';
import '../models/domain/multilingual_string.dart';
import '../components/page_card.dart';
import 'unorderd_list.dart';

class SummaryPageCard extends PageCard {
  const SummaryPageCard({Key? key, required this.items}) : super(key: key);
  final List<MultilingualRichText> items;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Caption
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: const Text("Summary", //TODO: i18n
                  style: TextStyle(fontSize: 30)),
              margin: const EdgeInsets.only(bottom: 20))
        ],
      ),
      // Summary content
      Expanded(child: UnorderdList(items: items)),

      // Complete button
      Row(
        children: [
          Expanded(
              child: ElevatedButton(
            onPressed: () {
              //TODO: Complete button process
              Navigator.pop(context);
            },
            child: const Text('Complete Lesson'),
          ))
        ],
      )
    ]);
  }
}
