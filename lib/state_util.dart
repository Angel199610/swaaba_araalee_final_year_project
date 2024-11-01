// TODO Implement this library.

// lib/utils/state_util.dart
import 'package:flutter/material.dart';

class StateUtil {
  // Navigator key to access the navigator from anywhere in the app
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Helper function to push a new screen
  static Future<T?> push<T>(Widget page) async {
    return await navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Helper function to push a replacement screen (clears the current screen)
  static Future<T?> pushReplacement<T>(Widget page) async {
    return await navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Helper function to pop (go back to previous screen)
  static void pop<T>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }

  /// Helper function to pop until a specific condition (useful for returning to the root)
  static void popUntil(bool Function(Route<dynamic>) predicate) {
    navigatorKey.currentState?.popUntil(predicate);
  }

  /// Helper function to show a snackbar
  static void showSnackbar(String message, {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(content: Text(message), duration: duration),
    );
  }
}
