import 'package:flutter/material.dart';

/// A widget that conditionally displays its child based on a boolean condition.
///
/// [When] provides a declarative way to show or hide widgets based on a condition.
/// If the [condition] is true, the [child] is displayed. Otherwise, the [otherwise]
/// widget is shown, or an empty [SizedBox] if [otherwise] is not provided.
///
/// This is useful for conditional rendering without using ternary operators directly
/// in the widget tree, making the code more readable.
///
/// Example:
/// ```dart
/// When(
///   condition: isLoggedIn,
///   child: UserProfile(),
///   otherwise: LoginButton(),
/// )
///
/// // Without otherwise
/// When(
///   condition: showDetails,
///   child: DetailedView(),
/// )
/// ```
class When extends StatelessWidget {
  /// The condition that determines which widget to display.
  final bool condition;

  /// The widget to display when [condition] is true.
  final Widget child;

  /// The widget to display when [condition] is false.
  /// If not provided, an empty [SizedBox] is shown.
  final Widget? otherwise;

  const When({
    required this.condition,
    required this.child,
    this.otherwise,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return condition ? child : (otherwise ?? const SizedBox());
  }
}
