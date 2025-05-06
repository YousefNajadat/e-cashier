import 'package:flutter/material.dart';
extension ContextX on BuildContext {
  /// Access MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  /// Access ThemeData
  ThemeData get theme => Theme.of(this);
  /// Access TextTheme
  TextTheme get textTheme => theme.textTheme;
  /// Push a new route
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }
  /// Replace current route with a new one
  Future<T?> pushReplacement<T, TO>(Widget page) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }
  /// Push and remove all previous routes until predicate returns true
  Future<T?> pushAndRemoveUntil<T>(Widget page, {bool Function(Route<dynamic>)? predicate}) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      predicate ?? (route) => false,
    );
  }
  /// Pop the current route
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }
}