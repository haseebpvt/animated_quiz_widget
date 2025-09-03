# Animated Quiz Widget 📝

A comprehensive, animated quiz widget package for Flutter with navigation, progress tracking, gradient backgrounds, and customizable styling.

[![pub package](https://img.shields.io/pub/v/animated_quiz_widget.svg)](https://pub.dev/packages/animated_quiz_widget)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🎬 Demo

![Animated Quiz Widget Demo](https://raw.githubusercontent.com/haseebpvt/animated_quiz_widget/main/demo/demo.gif)

*Experience smooth animations, gradient backgrounds, auto-navigation, and completion feedback*

**Features showcased in the demo:**
- ✨ Smooth slide and fade animations between questions
- 🎨 Beautiful gradient backgrounds with completion state changes  
- 📊 Embedded progress tracking (2/5 format)
- 🚀 Auto-navigation after answer selection
- ↩️ Back button functionality
- 🎉 Green gradient completion feedback

## Features ✨

- 🎯 **Multiple Choice Questions** - Support for dynamic question and answer lists
- 🧭 **Smart Navigation** - Navigate between questions with embedded controls
- 📊 **Progress Tracking** - Visual progress indicator showing current question (e.g., 2/10)
- 🚀 **Auto-Navigation** - Automatic progression after answer selection with customizable delay
- 🔒 **Answer Validation** - Require answers before allowing progression
- ↩️ **Flexible Navigation** - Always allow going back to edit previous answers
- 📐 **Consistent Height** - Maintains consistent widget height throughout the quiz
- 🎨 **Gradient Backgrounds** - Beautiful gradient backgrounds with completion state changes
- 🎉 **Completion Feedback** - Green gradient background when quiz is completed
- ✨ **Smooth Animations** - Elegant slide and fade animations with fixed container
- 🎯 **Rounded Ripples** - Properly clipped ripple effects for radio buttons
- 📱 **Mobile Optimized** - Responsive design with proper overflow handling

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  animated_quiz_widget: ^1.0.3
```

Then run:

```bash
flutter pub get
```

## Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:animated_quiz_widget/quiz_view.dart';

class MyQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: EdgeInsets.all(16),
          child: QuizWidget(
            questions: [
              QuizQuestion(
                id: 'q1',
                question: 'What is your favorite programming language?',
                options: [
                  'Dart/Flutter',
                  'JavaScript/TypeScript',
                  'Python',
                  'Java/Kotlin',
                ],
              ),
              QuizQuestion(
                id: 'q2',
                question: 'Which development approach do you prefer?',
                options: [
                  'Native Development',
                  'Cross-platform',
                  'Hybrid',
                ],
              ),
            ],
            onQuizCompleted: (questions) {
              // Handle quiz completion
              print('Quiz completed!');
              for (var question in questions) {
                print('${question.question}: ${question.selectedAnswer}');
              }
            },
          ),
        ),
      ),
    );
  }
}
```

## Advanced Usage

### Custom Configuration with Gradients

```dart
QuizWidget(
  questions: myQuestions,
  config: QuizConfig(
    backgroundColor: Color(0xFF1E3A8A),
    cornerRadius: 16,
    padding: EdgeInsets.all(24),
    showProgressIndicator: true,
    requireAnswerToProgress: true,
    allowBackwardNavigation: true,
    enableAutoNavigation: true,
    autoNavigationDelay: Duration(milliseconds: 1000),
    useGradientBackground: true,
    gradientColors: [
      Color(0xFF1E3A8A), // Deep blue
      Color(0xFF3B4CCA), // Royal blue
      Color(0xFF1E3A8A), // Back to deep blue
    ],
    animationDuration: Duration(milliseconds: 300),
  ),
  onAnswerChanged: (question, answer) {
    print('Question ${question.id} answered: $answer');
  },
  onQuizCompleted: (questions) {
    _showResults(questions);
  },
)
```

### Question Model Properties

```dart
QuizQuestion(
  id: 'unique_id',              // Required: Unique identifier
  question: 'Your question?',   // Required: The question text
  options: ['A', 'B', 'C'],     // Required: List of answer options
  selectedAnswer: null,         // Optional: Pre-selected answer
)

// Check if answered
bool isAnswered = question.isAnswered;
```

## Configuration Options

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `backgroundColor` | `Color` | `Color(0xFF1E3A8A)` | Background color (used when gradients disabled) |
| `textColor` | `Color` | `Colors.white` | Text color for options and UI elements |
| `questionTextColor` | `Color` | `Colors.white` | Text color for question text |
| `cornerRadius` | `double` | `12` | Corner radius for rounded edges |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.all(20)` | Internal padding of the widget |
| `showProgressIndicator` | `bool` | `true` | Show/hide progress indicator |
| `requireAnswerToProgress` | `bool` | `true` | Require answer before going to next question |
| `allowBackwardNavigation` | `bool` | `true` | Allow going back to previous questions |
| `enableAutoNavigation` | `bool` | `true` | Auto-navigate after answer selection |
| `autoNavigationDelay` | `Duration` | `Duration(milliseconds: 800)` | Delay before auto-navigation |
| `useGradientBackground` | `bool` | `true` | Enable gradient backgrounds |
| `gradientColors` | `List<Color>?` | `null` | Custom gradient colors (uses default if null) |
| `animationDuration` | `Duration` | `Duration(milliseconds: 300)` | Animation duration for transitions |
| `questionFontSize` | `double` | `20` | Font size for question text |
| `optionFontSize` | `double` | `18` | Font size for option text |

## Navigation Behavior

- **Embedded Controls**: Progress indicator and back button are embedded within the quiz widget
- **Auto-Navigation**: Automatically moves to next question after answer selection (configurable delay)
- **Forward Navigation**: Only allowed if current question is answered (when `requireAnswerToProgress` is true)
- **Backward Navigation**: Always allowed via embedded back button (when `allowBackwardNavigation` is true)
- **Progress Indicator**: Shows current position (e.g., "2/10") in the top-left corner
- **Quiz Completion**: Background changes to green gradient and triggers `onQuizCompleted` callback

## Visual Features

### Gradient Backgrounds
- **Default State**: Beautiful blue gradient background
- **Completion State**: Automatically changes to green gradient when last question is answered
- **Customizable**: Provide your own gradient colors via `gradientColors` property

### Animations
- **Fixed Container**: The outer container stays fixed while content animates
- **Smooth Transitions**: Slide and fade animations between questions
- **Rounded Ripples**: Properly clipped ripple effects on radio button interactions
- **Content Alignment**: Left-aligned content for better readability

## Callbacks

### onAnswerChanged
Called whenever a user selects an answer:
```dart
onAnswerChanged: (QuizQuestion question, String? answer) {
  print('Question ${question.id}: $answer');
  // Save to database, analytics, etc.
}
```

### onQuizCompleted
Called when the quiz is completed (last question answered):
```dart
onQuizCompleted: (List<QuizQuestion> questions) {
  // All questions with their selected answers
  var results = questions.where((q) => q.isAnswered).toList();
  print('Answered ${results.length} out of ${questions.length} questions');
  
  // Show results dialog, navigate to results page, etc.
  _showResultsDialog(questions);
}
```

## Styling Examples

### Dark Theme with Custom Gradient
```dart
QuizConfig(
  useGradientBackground: true,
  gradientColors: [
    Color(0xFF1a1a1a),
    Color(0xFF2d2d2d),
    Color(0xFF1a1a1a),
  ],
  textColor: Colors.white,
  questionTextColor: Colors.white,
  cornerRadius: 16,
)
```

### Light Theme (Solid Color)
```dart
QuizConfig(
  useGradientBackground: false,
  backgroundColor: Colors.white,
  textColor: Colors.black87,
  questionTextColor: Colors.black,
  cornerRadius: 12,
)
```

### Colorful Theme
```dart
QuizConfig(
  useGradientBackground: true,
  gradientColors: [
    Colors.deepPurple,
    Colors.purple,
    Colors.deepPurple,
  ],
  textColor: Colors.white,
  questionTextColor: Colors.yellow,
  cornerRadius: 20,
  padding: EdgeInsets.all(24),
)
```

## Widget Architecture

```
QuizWidget (Fixed Container with Gradient Background)
├── Fixed Header
│   ├── Progress Indicator (2/10)
│   └── Back Button (if enabled)
└── Animated Content Area
    └── AnimatedSwitcher (Question Transitions)
        └── AnimatedRadioColumn (Individual Questions)
            ├── Question Text (Bold, Left-aligned)
            └── Radio Options with Rounded Ripples
```

## Example App

Check out the `example/` directory for a complete working example that demonstrates:

- Multiple question types
- Custom styling and gradients
- Answer handling and results display
- Responsive design patterns

To run the example:

```bash
cd example
flutter pub get
flutter run
```

## Requirements

- Flutter SDK: `>=3.0.0`
- Dart SDK: `^3.4.0`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you like this package, please give it a ⭐ on [GitHub](https://github.com/haseebpvt/animated_quiz_widget) and a 👍 on [pub.dev](https://pub.dev/packages/animated_quiz_widget)!

For issues and feature requests, please use the [GitHub issue tracker](https://github.com/haseebpvt/animated_quiz_widget/issues).