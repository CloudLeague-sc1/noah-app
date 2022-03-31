import 'package:flutter/material.dart';
import 'package:noah/components/noah_rich_text.dart';
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
    final options =
        page.options.map((e) => MultipleChoiceQuizOption(option: e)).toList();
    return Column(
      children: [
        NoahRichText(model: getLocaleRichText(page.question, context)),
        ...options
      ],
    );
  }
}

class MultipleChoiceQuizOption extends StatelessWidget {
  final QuizOption option;
  const MultipleChoiceQuizOption({Key? key, required this.option})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          //TODO: Implement animation
          print(option.correct);
        },
        child: Text(getLocaleText(option.label, context)));
  }
}
