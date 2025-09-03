import 'dart:async';
import 'package:flutter/material.dart';
import '../models/quiz_models.dart';
import '../animated_text_column.dart';

/// A comprehensive quiz widget that manages multiple questions with navigation
class QuizWidget extends StatefulWidget {
  final List<QuizQuestion> questions;
  final QuizConfig config;
  final QuizCompletedCallback? onQuizCompleted;
  final QuizAnswerCallback? onAnswerChanged;
  final int initialQuestionIndex;

  const QuizWidget({
    super.key,
    required this.questions,
    this.config = const QuizConfig(),
    this.onQuizCompleted,
    this.onAnswerChanged,
    this.initialQuestionIndex = 0,
  });

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  late int _currentQuestionIndex;
  late List<QuizQuestion> _questions;
  double? _maxHeight;
  final GlobalKey _containerKey = GlobalKey();
  Timer? _autoNavigationTimer;
  bool _isQuizCompleted = false;

  @override
  void initState() {
    super.initState();
    _currentQuestionIndex = widget.initialQuestionIndex;
    _questions = List.from(widget.questions);
    
    // Calculate max height after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateMaxHeight();
    });
  }

  @override
  void dispose() {
    _autoNavigationTimer?.cancel();
    super.dispose();
  }

  /// Calculate the maximum height needed for all questions
  void _calculateMaxHeight() async {
    double maxHeight = 0;
    
    for (int i = 0; i < _questions.length; i++) {
      // Approximate height calculation based on text content
      double questionHeight = _estimateQuestionHeight(_questions[i]);
      if (questionHeight > maxHeight) {
        maxHeight = questionHeight;
      }
    }
    
    // Add padding and navigation controls height
    maxHeight += 200; // Extra space for navigation and padding
    
    if (mounted) {
      setState(() {
        _maxHeight = maxHeight;
      });
    }
  }

  /// Estimate the height needed for a question
  double _estimateQuestionHeight(QuizQuestion question) {
    // Base height for padding and structure
    double height = 100;
    
    // Add height for question text (approximate)
    final questionLines = (question.question.length / 40).ceil();
    height += questionLines * (widget.config.questionFontSize + 8);
    
    // Add height for each option
    for (String option in question.options) {
      final optionLines = (option.length / 50).ceil();
      height += optionLines * (widget.config.optionFontSize + 16) + 8;
    }
    
    return height;
  }

  /// Check if user can navigate to the next question
  bool _canGoNext() {
    if (!widget.config.requireAnswerToProgress) return true;
    return _questions[_currentQuestionIndex].isAnswered;
  }

  /// Check if user can navigate to the previous question
  bool _canGoPrevious() {
    return widget.config.allowBackwardNavigation && _currentQuestionIndex > 0;
  }



  /// Navigate to the next question
  void _nextQuestion() {
    // Cancel auto-navigation timer if user manually navigates
    _autoNavigationTimer?.cancel();
    _autoNavigationTimer = null;
    
    if (_canGoNext() && _currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else if (_currentQuestionIndex == _questions.length - 1 && _canGoNext()) {
      // Quiz completed - change to green background
      setState(() {
        _isQuizCompleted = true;
      });
      widget.onQuizCompleted?.call(_questions);
    }
  }

  /// Navigate to the previous question
  void _previousQuestion() {
    // Cancel auto-navigation timer if user manually navigates
    _autoNavigationTimer?.cancel();
    _autoNavigationTimer = null;
    
    if (_canGoPrevious()) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  /// Handle answer selection
  void _onAnswerSelected(String? answer) {
    // Cancel any existing auto-navigation timer
    _autoNavigationTimer?.cancel();
    _autoNavigationTimer = null;
    
    setState(() {
      _questions[_currentQuestionIndex] = _questions[_currentQuestionIndex]
          .copyWith(selectedAnswer: answer);
    });
    
    widget.onAnswerChanged?.call(_questions[_currentQuestionIndex], answer);
    
    // Check if this is the last question and it's now answered
    if (_currentQuestionIndex == _questions.length - 1 && answer != null) {
      // Last question answered - change to green background immediately
      setState(() {
        _isQuizCompleted = true;
      });
      // Delay the completion callback slightly to show the green background
      Timer(const Duration(milliseconds: 500), () {
        if (mounted) {
          widget.onQuizCompleted?.call(_questions);
        }
      });
    } else if (widget.config.enableAutoNavigation && 
        answer != null && 
        _currentQuestionIndex < _questions.length - 1) {
      // Auto-navigate to next question if not the last one
      _autoNavigationTimer = Timer(widget.config.autoNavigationDelay, () {
        if (mounted && _currentQuestionIndex < _questions.length - 1) {
          _nextQuestion();
        }
      });
    }
    
    // Force rebuild to update button states
    if (mounted) {
      setState(() {});
    }
  }



  /// Build the content for a specific question
  Widget _buildQuestionContent(QuizQuestion question, int index) {
    return AnimatedRadioColumn(
      question: question.question,
      options: question.options,
      cornerRadius: widget.config.cornerRadius, // Keep corner radius for ripple effects
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), // Only side and bottom padding since top is handled by fixed header
      initialValue: question.selectedAnswer,
      showBackButton: false, // Handled by fixed header
      onChanged: _onAnswerSelected,
    );
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _containerKey,
      height: _maxHeight,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: _isQuizCompleted 
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF4CAF50), // Green
                    Color(0xFF66BB6A), // Lighter green
                    Color(0xFF2E7D32), // Darker green
                  ],
                  stops: [0.0, 0.6, 1.0],
                )
              : widget.config.useGradientBackground ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.config.gradientColors ?? [
                    widget.config.backgroundColor,
                    widget.config.backgroundColor.withBlue(
                      (widget.config.backgroundColor.blue * 0.8).round().clamp(0, 255),
                    ).withGreen(
                      (widget.config.backgroundColor.green + 20).clamp(0, 255),
                    ),
                    widget.config.backgroundColor.withOpacity(0.95),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ) : null,
            color: (!widget.config.useGradientBackground && !_isQuizCompleted) ? widget.config.backgroundColor : null,
            borderRadius: BorderRadius.circular(widget.config.cornerRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: widget.config.backgroundColor.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 25,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fixed header with progress and back button
              _buildFixedHeader(),
              
              // Animated content area
              Expanded(
                child: AnimatedSwitcher(
                  duration: widget.config.animationDuration,
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: animation.drive(
                        Tween<Offset>(
                          begin: const Offset(0.3, 0),
                          end: Offset.zero,
                        ).chain(CurveTween(curve: Curves.easeOut)),
                      ),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      key: ValueKey(_currentQuestionIndex),
                      child: _buildQuestionContent(_questions[_currentQuestionIndex], _currentQuestionIndex),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build the fixed header with progress and back button
  Widget _buildFixedHeader() {
    return Container(
      padding: widget.config.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Progress number
          if (widget.config.showProgressIndicator)
            Text(
              '${_currentQuestionIndex + 1}/${_questions.length}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            )
          else
            const SizedBox(),
          
          // Back button
          if (_currentQuestionIndex > 0 && widget.config.allowBackwardNavigation)
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: _previousQuestion,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 16,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
