import 'package:flutter/material.dart';
import '../models/domain/page.dart';
import '../models/multilingual_text_util.dart';
import '../components/page_card.dart';

abstract class QuizPageCard extends PageCard {
  final QuizType type;
  const QuizPageCard({Key? key, required this.type}) : super(key: key);
}

QuizPageCard renderQuizPageCard(Quiz page) {
  if (page is MultipleChoiceQuiz) {
    return MultipleChoiceQuizPageCard(page: page);
  } else {
    final type = page.quizType.toString();
    throw Exception('Encounterd unknown quiz type $type while rendering quiz');
  }
}

class MultipleChoiceQuizPageCard extends QuizPageCard {
  final MultipleChoiceQuiz page;
  const MultipleChoiceQuizPageCard({Key? key, required this.page})
      : super(key: key, type: QuizType.multipleChoice);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(getLocaleRichText(page.question, context).toString()),
    );
  }
}
