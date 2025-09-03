# Changelog

All notable changes to this project will be documented in this file.

## [1.0.3] - 2024-12-19

### Repository & Documentation
* **Added GitHub Repository** - Connected package to official GitHub repository
* **Fixed Demo GIF Display** - Now shows actual animated demo using GitHub raw URL
* **Updated Package URLs** - All links now point to the correct GitHub repository
* **Enhanced Visual Demo** - Users can now see the actual GIF demonstration on pub.dev
* **Improved Package Metadata** - Better discoverability with proper repository links

## [1.0.2] - 2024-12-19

### Documentation
* **Fixed Demo Display** - Replaced broken GIF reference with descriptive demo section
* **Enhanced Demo Description** - Added detailed feature showcase in demo section
* **Improved User Guidance** - Clear instructions to run example app for interactive demo
* **Better README Structure** - Reorganized demo section for better pub.dev compatibility

## [1.0.1] - 2024-12-19

### Documentation
* **Added Demo GIF** - Added visual demonstration of the quiz widget in action
* **Enhanced README** - Improved README with demo section showing animations, gradients, and interactions
* **Better User Experience** - Users can now see the package functionality at a glance

## [1.0.0] - 2024-12-19

### Features
* **Initial Release** - Comprehensive animated quiz widget package
* **Multi-Question Support** - Handle multiple questions with navigation
* **Auto-Navigation** - Automatic progression after answer selection with customizable delay
* **Progress Tracking** - Visual progress indicator showing current question (X/Y format)
* **Gradient Backgrounds** - Beautiful gradient backgrounds with completion state changes
* **Customizable Styling** - Full control over colors, padding, corner radius, and fonts
* **Smooth Animations** - Elegant slide and fade transitions between questions
* **Mobile Optimized** - Responsive design with proper overflow handling
* **Completion Feedback** - Green gradient background on quiz completion
* **Backward Navigation** - Allow users to go back and edit previous answers
* **Answer Persistence** - Maintains selected answers when navigating between questions
* **Rounded Ripples** - Properly clipped ripple effects for radio button interactions

### Components
* `QuizWidget` - Main quiz container with navigation and progress tracking
* `AnimatedRadioColumn` - Individual question display with animated radio options
* `QuizQuestion` - Data model for questions and answers with state management
* `QuizConfig` - Configuration class for extensive customization options

### Configuration Options
* Background colors and gradient customization
* Corner radius and padding adjustments
* Animation durations and auto-navigation delays
* Progress indicator visibility controls
* Navigation behavior settings
* Text styling and font size options
* Auto-navigation timing configuration

### Technical Features
* Null safety support
* Consistent widget height across all questions
* Embedded progress and navigation controls
* Fixed container with content-only animations
* Left-aligned content layout
* Proper state management and callbacks