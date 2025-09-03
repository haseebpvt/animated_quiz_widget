# Quiz View Example

This example demonstrates how to use the `quiz_view` package to create beautiful, animated quiz interfaces in Flutter.

## Features Demonstrated

- **Multi-question quiz** with navigation
- **Auto-navigation** after answer selection
- **Progress tracking** with embedded indicators
- **Gradient backgrounds** with completion state changes
- **Customizable styling** and animations
- **Answer persistence** and backward navigation

## Running the Example

1. Navigate to the example directory:
   ```bash
   cd example
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Code Overview

The example shows how to:

1. **Create quiz questions** using the `QuizQuestion` model
2. **Configure the widget** using `QuizConfig` for customization
3. **Handle callbacks** for answer changes and quiz completion
4. **Display results** when the quiz is finished

## Key Configuration Options

- `backgroundColor` and `gradientColors` for styling
- `cornerRadius` and `padding` for layout
- `enableAutoNavigation` and `autoNavigationDelay` for UX
- `allowBackwardNavigation` and `requireAnswerToProgress` for flow control

See the main package documentation for complete configuration options.
