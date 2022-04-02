import 'dart:convert';

import 'package:noah/models/domain/lesson.dart';
import 'package:noah/models/domain/multilingual_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noah/models/domain/course.dart';

class Progress {
  MultilingualText courseTitle;
  List<LessonProgress> courseProgress;
  Progress(this.courseTitle, this.courseProgress);

  Map toJson() => {
    'title': courseTitle.toJson(),
    'lessons': courseProgress.map((e) => e.toJson())
  };

  Progress.fromJson(Map<String, dynamic> json)
  : courseTitle = json['title'],
  courseProgress = json['lessons'];
}


class ProgressManager {
  Progress progress;

  ProgressManager(this.progress);

  Future<Progress> getProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final String? result = prefs.getString('progress');
    if (result != null) {
      progress = Progress.fromJson(json.decode(result));
      return progress;
    } else {
      throw Exception('Progress data is null');
    }
  }

  Future<void> saveProgress(Progress progress) async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.encode(progress.toJson());
    await prefs.setString('progress', data);
  }

}