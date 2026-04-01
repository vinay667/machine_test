# flutter_mvp32

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)


🧱 Architecture Overview

This project follows the MVVM (Model-View-ViewModel) architecture:

**Model**
Represents the data layer (UserModel) and handles JSON parsing.
**View**
UI components (screens & widgets) responsible for displaying data on UI.
**ViewModel**
Business logic layer using GetX Controllers (HomeViewModel).
Handles:
API calls via repository
State management
Search, sorting, filtering
Repository Layer
Acts as an abstraction between API and ViewModel.
Service Layer
Handles API calls using the http package.
⚙️ State Management & Architecture Choice
State Management: GetX
Architecture: MVVM
I have used GetX because it is
Lightweight and fast
Simple reactive state management (.obs)
Built-in dependency injection
Easy navigation handling
Why MVVM?
Clear separation of concerns
Scalable and maintainable
Easy to test and extend



For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
