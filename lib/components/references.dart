import 'package:flutter/material.dart';
import '../models/domain/references.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferenceBox extends StatelessWidget {
  final List<ReferenceItem> refs;
  const ReferenceBox({Key? key, required this.refs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = refs.map(renderReferenceItem).toList();
    return Column(children: items,mainAxisAlignment: MainAxisAlignment.start,);
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

    return TextButton(child: Text("$title ($asOf)"),onPressed: (){
      launch(url);
    });
  }
}
