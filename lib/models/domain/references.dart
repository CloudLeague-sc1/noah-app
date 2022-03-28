enum ReferenceType { web }

class ReferenceItem {
  ReferenceType type = ReferenceType.web;
  ReferenceItem(this.type);
}

class WebItem extends ReferenceItem {
  String url = "";
  String title = "";
  String asOf = "";
  WebItem(this.url) : super(ReferenceType.web);
}

ReferenceItem parseReferenceItem(Map<String, dynamic> json) {
  if (json['type'] is! String) {
    throw Exception("Reference type is not string");
  }
  final type = json['type'];
  switch (type) {
    case 'web':
      return WebItem(json['url']);
    default:
      throw Exception("Unknown reference type `$type`");
  }
}
