import 'package:flutter/material.dart';

class AnimatedRadioColumn extends StatefulWidget {
  final List<String> options; // dynamic list of options
  final ValueChanged<String?>? onChanged; // callback when selected
  final String? question; // optional question text to display at top
  final EdgeInsetsGeometry? padding; // customizable padding
  final double cornerRadius; // customizable corner radius
  final String? initialValue; // initial selected value
  final int? currentQuestionNumber; // current question number (1-based)
  final int? totalQuestions; // total number of questions
  final VoidCallback? onBackPressed; // callback for back button
  final bool showBackButton; // whether to show back button

  const AnimatedRadioColumn({
    super.key,
    required this.options,
    this.onChanged,
    this.question,
    this.padding = const EdgeInsets.all(20),
    this.cornerRadius = 12,
    this.initialValue,
    this.currentQuestionNumber,
    this.totalQuestions,
    this.onBackPressed,
    this.showBackButton = false,
  });

  @override
  State<AnimatedRadioColumn> createState() => _AnimatedRadioColumnState();
}

class _AnimatedRadioColumnState extends State<AnimatedRadioColumn> {
  String? _selectedValue;
  late List<bool> _visibleList;
  int? _pressedIndex; // track which item is pressed
  bool _questionVisible = false; // track question visibility

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _visibleList = List.filled(widget.options.length, false);
    _animateOptions();
  }

  Future<void> _animateOptions() async {
    // Show question first if it exists
    if (widget.question != null) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        setState(() {
          _questionVisible = true;
        });
      }
      await Future.delayed(const Duration(milliseconds: 200));
    }
    
    // Then show options one by one
    for (int i = 0; i < widget.options.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        setState(() {
          _visibleList[i] = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];



    // Add question text if provided
    if (widget.question != null) {
      children.add(
        AnimatedOpacity(
          opacity: _questionVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: AnimatedSlide(
            offset: _questionVisible ? Offset.zero : const Offset(0, 0.2),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                widget.question!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Add radio options
    children.addAll(
      List.generate(widget.options.length, (index) {
        return AnimatedOpacity(
          opacity: _visibleList[index] ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: AnimatedSlide(
            offset: _visibleList[index] ? Offset.zero : const Offset(0, 0.2),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.cornerRadius),
              child: Material(
                color: Colors.transparent, // ✅ no background
                child: InkWell(
                  onTapDown: (_) {
                    setState(() => _pressedIndex = index);
                  },
                  onTapUp: (_) {
                    setState(() => _pressedIndex = null);
                  },
                  onTapCancel: () {
                    setState(() => _pressedIndex = null);
                  },
                  onTap: () {
                    setState(() {
                      _selectedValue = widget.options[index];
                    });
                    widget.onChanged?.call(_selectedValue);
                  },
                  child: AnimatedScale(
                    scale: _pressedIndex == index ? 0.97 : 1.0,
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeOut,
                    child: Theme(
                      data: ThemeData(
                        radioTheme: RadioThemeData(
                          fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                            if (states.contains(WidgetState.selected)) {
                              return Colors.white;
                            }
                            return Colors.white70;
                          }),
                        ),
                      ),
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          widget.options[index],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        value: widget.options[index],
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                          widget.onChanged?.call(value);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );

    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
