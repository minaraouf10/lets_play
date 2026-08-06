import 'package:flutter_test/flutter_test.dart';
import 'package:game_test/modules/home/games/data/datasources/grammar_data.dart';
import 'package:game_test/modules/home/games/data/datasources/word_lessons_data.dart';
import 'package:game_test/modules/home/games/domain/entities/grammar_lesson.dart';

void main() {
  group('grammar lesson data', () {
    test('l4_fi opens with a grammar section', () {
      expect(hasGrammarLesson('l4_fi'), isTrue);
      expect(grammarLessonFor('l4_fi'), isNotNull);
    });

    test('lessons without grammar go straight to the word steps', () {
      expect(hasGrammarLesson('l4_rajul'), isFalse);
      expect(hasGrammarLesson('l1_alef'), isFalse);
    });

    test('every question step keys on a real option', () {
      final steps = grammarLessonFor('l4_fi')!.steps;

      for (final step in steps) {
        switch (step) {
          case GrammarChoiceStepData(:final choice):
            expect(
              choice.options.map((o) => o.id),
              contains(choice.correctId),
              reason: 'choice "${choice.prompt}" has no matching option',
            );
          case GrammarFillBlankStepData(:final options, :final correctId):
            expect(
              options.map((o) => o.id),
              contains(correctId),
              reason: 'fill-blank has no option matching its correctId',
            );
          case GrammarCategoryStepData(:final options, :final correctId):
            expect(
              options.map((o) => o.id),
              contains(correctId),
              reason: 'category step has no option matching its correctId',
            );
          case GrammarPictureStepData(:final question):
            expect(
              question.options.map((o) => o.id),
              contains(question.correctId),
            );
          case GrammarEquationCard() ||
                GrammarTermsCard() ||
                GrammarStatementStepData():
            break;
        }
      }
    });

    test('option ids are unique within each question', () {
      for (final step in grammarLessonFor('l4_fi')!.steps) {
        final ids = switch (step) {
          GrammarChoiceStepData(:final choice) =>
            choice.options.map((o) => o.id).toList(),
          GrammarFillBlankStepData(:final options) =>
            options.map((o) => o.id).toList(),
          GrammarCategoryStepData(:final options) =>
            options.map((o) => o.id).toList(),
          GrammarPictureStepData(:final question) =>
            question.options.map((o) => o.id).toList(),
          _ => const <String>[],
        };
        expect(ids.toSet().length, ids.length,
            reason: 'duplicate option id would make two tiles indistinguishable');
      }
    });

    test('the noun questions key on the intended words', () {
      final steps = grammarLessonFor('l4_fi')!.steps;
      final choices = steps.whereType<GrammarChoiceStepData>().toList();

      final name = choices.first.choice.options
          .firstWhere((o) => o.id == choices.first.choice.correctId);
      expect(name.arabic, 'البيت');

      final noun = choices[1].choice.options
          .firstWhere((o) => o.id == choices[1].choice.correctId);
      expect(noun.arabic, 'كاتب');
    });

    test('the verb conjugation answers match their subjects', () {
      final blanks = grammarLessonFor('l4_fi')!
          .steps
          .whereType<GrammarFillBlankStepData>()
          .toList();

      // Each sentence's subject decides which conjugation is right.
      const expected = {
        'أُمي': 'طبخت', // feminine past
        'أنا': 'ذاكرتُ', // first person past
        'أخي': 'سافر', // third person singular past
        'نحن': 'نحتاج', // first person plural present
        'هي': 'تتحدث', // third person feminine present
        'هو': 'يلعب', // third person masculine present
      };

      for (final entry in expected.entries) {
        final step = blanks.firstWhere(
          (b) => b.before == entry.key && b.after != 'عن عمل.',
          orElse: () => blanks.firstWhere((b) => b.before == entry.key),
        );
        final answer =
            step.options.firstWhere((o) => o.id == step.correctId).arabic;
        expect(answer, entry.value,
            reason: '"${entry.key}" should take "${entry.value}"');
      }
    });

    test('the statement steps are correctly keyed', () {
      final statements = grammarLessonFor('l4_fi')!
          .steps
          .whereType<GrammarStatementStepData>()
          .toList();

      expect(statements, hasLength(2));

      // "يعمل" is a present-tense verb, so "This word is a Noun" is false.
      expect(statements.first.word, 'يعمل');
      expect(statements.first.isTrue, isFalse);

      // "اكتب الرسالة" is a command, so the imperative label holds.
      expect(statements.last.word, 'اكتب الرسالة');
      expect(statements.last.isTrue, isTrue);
      expect(statements.last.subtitle, isNotNull);
    });

    test('the verb category step keys on the past tense', () {
      final category = grammarLessonFor('l4_fi')!
          .steps
          .whereType<GrammarCategoryStepData>()
          .single;

      expect(category.word, 'أكل');
      final answer =
          category.options.firstWhere((o) => o.id == category.correctId);
      // "أكل" is past tense, not present or imperative.
      expect(answer.arabic, 'ماض');
    });

    test('reference cards need no answer, questions do', () {
      for (final step in grammarLessonFor('l4_fi')!.steps) {
        final expectReference =
            step is GrammarEquationCard || step is GrammarTermsCard;
        expect(step.isReference, expectReference);
      }
    });

    test('grammar hands off to a word lesson that exists', () {
      // The grammar page pushes the word lesson with the same id, so that
      // lookup must resolve or the hand-off dead-ends.
      expect(wordLessonFor('l4_fi'), isNotNull);
    });
  });
}
