import 'dart:math';
import 'package:flutter/material.dart';
import 'package:noah/components/noah_rich_text.dart';
import 'package:noah/models/domain/multilingual_string.dart';
import '../models/domain/page.dart';
import '../models/multilingual_text_util.dart';
import '../components/page_card.dart';

abstract class QuizPageCard extends PageCard {
  final QuizType type;
  const QuizPageCard({Key? key, required this.type, required nextPage})
      : super(key: key, nextPage: nextPage);
}

QuizPageCard renderQuizPageCard(Quiz page, VoidCallback nextPage) {
  if (page is MultipleChoiceQuiz) {
    return MultipleChoiceQuizPageCard(page: page, nextPage: nextPage);
  } else {
    final type = page.quizType.toString();
    throw Exception('Encounterd unknown quiz type $type while rendering quiz');
  }
}

class QuizCommentCaption extends StatelessWidget {
  final bool isCorrect;
  const QuizCommentCaption({Key? key, required this.isCorrect})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    const correctCaptions = ['Good', 'Great!', 'Congrats', 'Nice!', 'Super!'];
    const worngCaptions = [
      'Almost!',
      'Oops...',
      'Good try but...',
      'Incorrect :('
    ];
    final rand = Random()
        .nextInt(isCorrect ? correctCaptions.length : worngCaptions.length);
    final text = isCorrect ? correctCaptions[rand] : worngCaptions[rand];

    return Text(
      text,
      style: TextStyle(
        color: isCorrect ? Colors.green : Colors.amber.shade700,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class QuizCommentBody extends StatelessWidget {
  final MultilingualRichText comment;
  const QuizCommentBody({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: NoahRichText(
          model: getLocaleRichText(comment, context),
          baseStyle: const TextStyle(fontSize: 18),
        ));
  }
}

class QuizCommentCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const QuizCommentCloseButton({Key? key, required this.text,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Row(children: [
          Expanded(
              child: ElevatedButton(
            child: Text(text),
            onPressed: () {
              Navigator.pop(context);
              onPressed?.call();
            },
          ))
        ]));
  }
}

class MultipleChoiceQuizPageCard extends QuizPageCard {
  final MultipleChoiceQuiz page;
  const MultipleChoiceQuizPageCard(
      {Key? key, required this.page, required nextPage})
      : super(key: key, type: QuizType.multipleChoice, nextPage: nextPage);

  Color getSheetColor(bool isCorrect) {
    return isCorrect ? Colors.lightGreen.shade100 : Colors.amber.shade100;
  }

  void onOptionPressed(
      bool isCorrect, MultilingualRichText comment, BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          color: getSheetColor(isCorrect),
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Caption
                QuizCommentCaption(isCorrect: isCorrect),
                // Comment
                Expanded(child: QuizCommentBody(comment: comment)),
                // Close button
                QuizCommentCloseButton(
                  text: isCorrect? 'Next':'Try again',
                  onPressed: () {
                    if (isCorrect) {
                      nextPage?.call();
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final options = page.options
        .map((e) => MultipleChoiceQuizOption(
              option: e,
              onPressed: onOptionPressed,
            ))
        .toList();
    return Column(
      children: [
        NoahRichText(model: getLocaleRichText(page.question, context)),
        const Spacer(),
        ...options
      ],
    );
  }
}

class MultipleChoiceQuizOption extends StatelessWidget {
  final QuizOption option;
  final Function? onPressed;
  const MultipleChoiceQuizOption(
      {Key? key, required this.option, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: OutlinedButton(
                  onPressed: () {
                    if (onPressed != null) {
                      onPressed!(option.correct, option.comment, context);
                    }
                  },
                  child: Text(getLocaleText(option.label, context)))))
    ]);
  }
}
