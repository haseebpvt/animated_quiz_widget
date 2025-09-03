/// Quiz models for the reusable quiz widget package
library quiz_models;

import 'package:flutter/material.dart';

/// Represents a single quiz question with multiple choice answers
class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final bool isRequired;
  
  /// The selected answer for this question
  String? selectedAnswer;
  
  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    this.isRequired = true,
    this.selectedAnswer,
  });
  
  /// Check if this question has been answered
  bool get isAnswered => selectedAnswer != null && selectedAnswer!.isNotEmpty;
  
  /// Create a copy of this question with updated values
  QuizQuestion copyWith({
    String? id,
    String? question,
    List<String>? options,
    bool? isRequired,
    String? selectedAnswer,
  }) {
    return QuizQuestion(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      isRequired: isRequired ?? this.isRequired,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }
  
  @override
  String toString() {
    return 'QuizQuestion(id: $id, question: $question, options: $options, selectedAnswer: $selectedAnswer)';
  }
}

/// Configuration class for the quiz widget appearance and behavior
class QuizConfig {
  final EdgeInsetsGeometry padding;
  final double cornerRadius;
  final Color backgroundColor;
  final Color textColor;
  final Color questionTextColor;
  final double questionFontSize;
  final double optionFontSize;
  final bool showProgressIndicator;
  final bool allowBackwardNavigation;
  final bool requireAnswerToProgress;
  final Duration animationDuration;
  final bool enableAutoNavigation;
  final Duration autoNavigationDelay;
  final bool useGradientBackground;
  final List<Color>? gradientColors;
  
  const QuizConfig({
    this.padding = const EdgeInsets.all(20),
    this.cornerRadius = 12,
    this.backgroundColor = const Color(0xFF1E3A8A),
    this.textColor = const Color(0xFFFFFFFF),
    this.questionTextColor = const Color(0xFFFFFFFF),
    this.questionFontSize = 20,
    this.optionFontSize = 18,
    this.showProgressIndicator = true,
    this.allowBackwardNavigation = true,
    this.requireAnswerToProgress = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.enableAutoNavigation = true,
    this.autoNavigationDelay = const Duration(milliseconds: 800),
    this.useGradientBackground = true,
    this.gradientColors,
  });
}

/// Callback function type for when quiz is completed
typedef QuizCompletedCallback = void Function(List<QuizQuestion> questions);

/// Callback function type for when an answer is selected
typedef QuizAnswerCallback = void Function(QuizQuestion question, String? answer);
