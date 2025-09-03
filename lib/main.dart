import 'package:flutter/material.dart';
import 'package:animated_quiz_widget/quiz_view.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<QuizQuestion> _createSampleQuestions() {
    return [
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
        question: 'Which mobile development approach do you prefer?',
        options: [
          'Native Development (Swift/Kotlin)',
          'Cross-platform (Flutter/React Native)',
          'Hybrid (Ionic/Cordova)',
          'Web-based (PWA)',
        ],
      ),
      QuizQuestion(
        id: 'q3',
        question: 'What is most important when choosing a framework?',
        options: [
          'Performance and speed',
          'Developer experience and productivity',
          'Community support and ecosystem',
          'Learning curve and documentation',
          'Long-term maintenance and stability',
        ],
      ),
      QuizQuestion(
        id: 'q4',
        question: 'How often do you work on mobile app projects?',
        options: [
          'Daily - it\'s my main focus',
          'Weekly - regular part of my work',
          'Monthly - occasional projects',
          'Rarely - just learning or experimenting',
        ],
      ),
      QuizQuestion(
        id: 'q5',
        question: 'What type of apps do you primarily build?',
        options: [
          'Business/Enterprise applications',
          'Consumer/Social apps',
          'E-commerce applications',
          'Games and entertainment',
          'Educational or productivity tools',
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Quiz Widget Demo'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(16),
          child: QuizWidget(
            questions: _createSampleQuestions(),
            config: const QuizConfig(
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
            ),
            onAnswerChanged: (question, answer) {
              // Handle answer change - avoid print in production
              debugPrint('Question ${question.id}: $answer');
            },
            onQuizCompleted: (questions) {
              _showQuizResults(context, questions);
            },
          ),
        ),
      ),
    );
  }

  void _showQuizResults(BuildContext context, List<QuizQuestion> questions) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed! 🎉'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Here are your answers:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...questions.map((q) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(q.question, style: const TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text('Answer: ${q.selectedAnswer ?? "Not answered"}', 
                    style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}