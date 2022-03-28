import 'package:noah/models/domain/multilingual_string.dart';
import 'media.dart';
import 'annotation.dart';
import 'references.dart';

enum PageType { page, quiz }

class PageBase {
  PageType type = PageType.page;
  PageBase(PageType type);
}

class Page extends PageBase {
  MultilingualRichText text = MultilingualRichText.empty();
  Media? media;
  Annotation? annotation;
  List<ReferenceItem>? references;

  Page(this.text, this.media, this.annotation, this.references)
      : super(PageType.page);
  Page.fromJson(Map<String, dynamic> json) : super(PageType.page) {
    if (json['text'] is Map<String, dynamic>) {
      text = MultilingualRichText.fromJson(json['text']);
    }

    if (json['media'] is Map<String, dynamic>) {
      media = parseMedia(json['media']);
    }

    if (json['annotation'] is Map<String, dynamic>) {
      annotation = parseAnnotation(json['annotation']);
    }

    if (json['references'] is List) {
      references = json['references']
          .map((e) => parseReferenceItem)
          .toList()
          .cast<ReferenceItem>();
    }
  }
}

enum QuizType { multipleChoice }

class Quiz extends PageBase {
  QuizType quizType = QuizType.multipleChoice;
  Quiz(this.quizType) : super(PageType.quiz);
}

class QuizOption {
  bool correct = false;
  MultilingualText label = MultilingualText.empty();
  MultilingualRichText comment = MultilingualRichText.empty();

  QuizOption(this.correct, this.label, this.comment);
  QuizOption.fromJson(Map<String, dynamic> json) {
    correct = json['correct'];
    label = MultilingualText.fromJson(json['label']);
    comment = MultilingualRichText.fromJson(json['comment']);
  }
}

class MultipleChoiceQuize extends Quiz {
  MultilingualRichText question = MultilingualRichText.empty();
  List<QuizOption> options = [];
  MultipleChoiceQuize(this.question, this.options)
      : super(QuizType.multipleChoice);
  MultipleChoiceQuize.fromJson(Map<String, dynamic> json)
      : super(QuizType.multipleChoice) {
    question = MultilingualRichText.fromJson(json['question']);
    options = json['options']
        .map((e) => QuizOption.fromJson(e))
        .toList()
        .cast<QuizOption>();
  }
}

PageBase parseQuiz(Map<String, dynamic> json) {
  if (json['quiz_type'] is! String) {
    throw Exception("Quiz type is not string");
  }

  final type = json['quiz_type'];
  switch (type) {
    case 'multiple_choice':
      return MultipleChoiceQuize.fromJson(json);
    default:
      throw Exception("Unknown page type: $type");
  }
}

PageBase parsePage(Map<String, dynamic> json) {
  if (json['type'] is! String) {
    throw Exception("Page type is not string");
  }

  final type = json['type'];
  switch (type) {
    case 'page':
      return Page.fromJson(json);
    case 'quiz':
      return parseQuiz(json);
    default:
      throw Exception("Unknown page type: $type");
  }
}