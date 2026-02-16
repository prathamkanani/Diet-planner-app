import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  /// Shorthand method to push navigate to a required [child].
  ///
  /// Parameters:
  /// * [child] : The required destination.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Widget build(final BuildContext context) {
  ///   return SomeUI(
  ///     onTap() => context.push(SomeOtherUI())
  ///   );
  /// }
  /// ```
  Future<T?> push<T>(Widget child) async {
    return Navigator.push(this, MaterialPageRoute(builder: (context) => child));
  }

  /// Shorthand method to push a required [child] and remove other routes.
  ///
  /// Parameters:
  /// * [child] : The required destination.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Widget build(final BuildContext context) {
  ///   return SomeUI(
  ///     onTap() => context.pushAndRemoveUntil(SomeOtherUI())
  ///   );
  /// }
  /// ```
  Future<void> pushAndRemoveUntil(Widget child) async {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => child),
      (context) => false,
    );
  }

  /// Shorthand method to push a required [child] instead of the top-most route.
  ///
  /// Parameters:
  /// * [child] : The required destination.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Widget build(final BuildContext context) {
  ///   return SomeUI(
  ///     onTap() => context.pushReplacement(SomeOtherUI())
  ///   );
  /// }
  /// ```
  Future<void> pushReplacement(Widget child) async {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => child),
    );
  }

  /// Shorthand method to pop a required [child].
  ///
  /// Parameters:
  /// * [child] : The required destination.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Widget build(final BuildContext context) {
  ///   return SomeUI(
  ///     onTap() => context.pop(SomeOtherUI())
  ///   );
  /// }
  /// ```
  Future<void> pop() async {
    Navigator.pop(this);
  }

  /// Shorthand getter to apply ColorScheme to any widget.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Widget build(final BuildContext context) {
  ///   return SomeUI(
  ///     color: cs.primary;
  ///   );
  /// }
  /// ```
  ColorScheme get cs {
    return ColorScheme.of(this);
  }
}
