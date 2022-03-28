import 'multilingual_string.dart';
import 'page.dart';

class Lesson {
  MultilingualText title = MultilingualText.empty();
  List<PageBase> pages = [];
  List<MultilingualRichText> summary = [];
  Lesson(this.title, this.pages, this.summary);
  Lesson.fromJson(Map<String, dynamic> json) {
    title = MultilingualText.fromJson(json['title']);
    pages = json['pages'].cast<Map<String,dynamic>>().map(parsePage).toList().cast<PageBase>();
    summary =
        json['summary'].map((e) => MultilingualRichText.fromJson(e)).toList().cast<MultilingualRichText>();
  }
}
