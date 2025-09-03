import 'package:flutter_test/flutter_test.dart';
import 'package:animated_quiz_widget/quiz_view.dart';

void main() {
  group('QuizQuestion Tests', () {
    test('QuizQuestion model works correctly', () {
      final question = QuizQuestion(
        id: 'test',
        question: 'Test question?',
        options: ['Option A', 'Option B', 'Option C'],
      );

      // Initially not answered
      expect(question.isAnswered, isFalse);
      expect(question.selectedAnswer, isNull);

      // After selecting an answer
      question.selectedAnswer = 'Option A';
      expect(question.isAnswered, isTrue);
      expect(question.selectedAnswer, equals('Option A'));
    });

    test('QuizConfig has correct defaults', () {
      const config = QuizConfig();
      
      expect(config.cornerRadius, equals(12));
      expect(config.showProgressIndicator, isTrue);
      expect(config.requireAnswerToProgress, isTrue);
      expect(config.allowBackwardNavigation, isTrue);
      expect(config.enableAutoNavigation, isTrue);
      expect(config.useGradientBackground, isTrue);
    });

    test('QuizConfig can be customized', () {
      const config = QuizConfig(
        cornerRadius: 20,
        showProgressIndicator: false,
        requireAnswerToProgress: false,
        allowBackwardNavigation: false,
        enableAutoNavigation: false,
        useGradientBackground: false,
      );
      
      expect(config.cornerRadius, equals(20));
      expect(config.showProgressIndicator, isFalse);
      expect(config.requireAnswerToProgress, isFalse);
      expect(config.allowBackwardNavigation, isFalse);
      expect(config.enableAutoNavigation, isFalse);
      expect(config.useGradientBackground, isFalse);
    });
  });
}