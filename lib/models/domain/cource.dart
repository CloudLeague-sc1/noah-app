import 'multilingual_string.dart';
import 'lesson.dart';

class Cource {
  MultilingualText title = MultilingualText("", "");
  MultilingualText description = MultilingualText("", "");
  List<Lesson> lessons = [];

  Cource(this.title, this.description, this.lessons);
  Cource.fromJson(Map<String, dynamic> json) {
    title = MultilingualText.fromJson(json['title']);
    description = MultilingualText.fromJson(json['description']);
    lessons =
        json['lessons'].map((e) => Lesson.fromJson(e)).toList().cast<Lesson>();
  }

  Cource.empty();
}

class CourceMetadata {
  String source = "";
  CourceMetadata(this.source);
  CourceMetadata.fromJson(Map<String, dynamic> obj) {
    if (obj['source'] is! String) {
      throw Exception(
          "Failed to load CourceMetaData from JSON. source is not String");
    }
    source = obj['source'];
  }
}

class CourceWithMetadata {
  CourceMetadata meta = CourceMetadata("");
  Cource cource = Cource.empty();

  CourceWithMetadata(this.meta, this.cource);
  CourceWithMetadata.fromJson(Map<String, dynamic> obj) {
    meta = CourceMetadata.fromJson(obj['meta']);
    cource = Cource.fromJson(obj['cource']);
  }
}
