import 'package:flutter/material.dart';
import '../models/domain/references.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferenceBox extends StatelessWidget {
  final List<ReferenceItem> refs;
  const ReferenceBox({Key? key, required this.refs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = refs.map(renderReferenceItem).toList();
    return Container(
      margin: const EdgeInsets.all(10),
        child: Column(
      children: [const ReferenceBoxCaption(), ...items],
    ));
  }
}

class ReferenceBoxCaption extends StatelessWidget {
  const ReferenceBoxCaption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: const [
      Text('References',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ))
    ]);
  }
}

Widget renderReferenceItem(ReferenceItem item) {
  if (item is WebItem) {
    return WebReferenceItem(item: item);
  }
  throw Exception('Unknown reference type');
}

class WebReferenceItem extends StatelessWidget {
  final WebItem item;
  const WebReferenceItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final asOf = item.asOf;
    final title = item.title;
    final url = item.url;

    return Row(children: [
      const Text('・'),
      GestureDetector(
        onTap: () {
          launch(url);
        },
        child: Text(
          " $title ($asOf)",
          style: TextStyle(color: Colors.blue.shade800),
        ),
      )
    ]);
  }
}
