import 'dart:ffi';

import 'multilingual_string.dart';
import 'lesson.dart';

class Course {
  MultilingualText title = MultilingualText("", "");
  MultilingualText description = MultilingualText("", "");
  List<Lesson> lessons = [];

  Course(this.title, this.description, this.lessons);
  Course.fromJson(Map<String, dynamic> json) {
    title = MultilingualText.fromJson(json['title']);
    description = MultilingualText.fromJson(json['description']);
    lessons =
        json['lessons'].map((e) => Lesson.fromJson(e)).toList().cast<Lesson>();
  }

  Course.empty();
}

class CourseMetadata {
  String source = "";
  CourseMetadata(this.source);
  CourseMetadata.fromJson(Map<String, dynamic> obj) {
    if (obj['source'] is! String) {
      throw Exception(
          "Failed to load CourseMetaData from JSON. source is not String");
    }
    source = obj['source'];
  }
}

class CourseWithMetadata {
  CourseMetadata meta = CourseMetadata("");
  Course course = Course.empty();

  CourseWithMetadata(this.meta, this.course);
  CourseWithMetadata.fromJson(Map<String, dynamic> obj) {
    meta = CourseMetadata.fromJson(obj['meta']);
    course = Course.fromJson(obj['course']);
  }
}
