enum ReferenceType { web }

class ReferenceItem {
  ReferenceType type = ReferenceType.web;
  ReferenceItem(this.type);
}

class WebItem extends ReferenceItem {
  String url = "";
  String title = "";
  String asOf = "";
  WebItem(this.url, this.title, this.asOf) : super(ReferenceType.web);
  WebItem.fromJson(Map<String, dynamic> json) : super(ReferenceType.web) {
    url = json['url'];
    title = json['title'];
    asOf = json['as_of'];
  }
}

ReferenceItem parseReferenceItem(Map<String, dynamic> json) {
  if (json['type'] is! String) {
    throw Exception("Reference type is not string");
  }
  final type = json['type'];
  switch (type) {
    case 'web':
      return WebItem.fromJson(json);
    default:
      throw Exception("Unknown reference type `$type`");
  }
}
