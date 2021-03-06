import 'package:noah/models/asset_interfaces.dart';
import './course.dart';

class Toc {
  // Table of Contents
  List<String> articles = [];
  List<String> samples = [];

  Toc(this.articles, this.samples);
  Toc.fromJson(Map<String, dynamic> json) {
    if (json['articles'] is! List<dynamic>) {
      throw Exception("Toc.fromJson: articles is not a List<dynamic>");
    }

    if (json['samples'] is! List<dynamic>) {
      throw Exception("Toc.fromJson: samples is not a List<dynamic>");
    }

    articles = json['articles'].cast<String>();
    samples = json['samples'].cast<String>();
  }

  Future<List<CourseWithMetadata>> getArticles() async {
    return await getContents(articles);
  }

  Future<List<CourseWithMetadata>> getSamples() async {
    return await getContents(samples);
  }

  Future<List<CourseWithMetadata>> getContents(
      List<String> contentNames) async {
    final jsonList = await Future.wait(
        contentNames.map((e) => loadJsonAsset('contents/$e')).toList());
    final jsonFlattenList = jsonList.expand((e) => e).toList();
    final jsonFlattenListCasted = jsonFlattenList.cast<Map<String, dynamic>>();
    return jsonFlattenListCasted.map(CourseWithMetadata.fromJson).toList();
  }
}
