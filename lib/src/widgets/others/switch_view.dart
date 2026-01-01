import 'package:flutter/material.dart';

/// A widget that displays different child widgets based on a value.
///
/// [SwitchView] provides a declarative way to show different widgets based on
/// a value, similar to a switch statement. If the value doesn't match any case,
/// the [fallback] widget is shown, or a [SizedBox] if no fallback is provided.
///
/// Type parameter [T] is the type of the value being switched on.
///
/// Example:
/// ```dart
/// enum Status { loading, success, error }
///
/// SwitchView<Status>(
///   value: currentStatus,
///   cases: {
///     Status.loading: CircularProgressIndicator(),
///     Status.success: Text('Success!'),
///     Status.error: Text('Error occurred'),
///   },
///   fallback: Text('Unknown status'),
/// )
/// ```
class SwitchView<T> extends StatelessWidget {
  /// The value to match against the cases.
  final T value;

  /// A map of possible values to their corresponding widgets.
  final Map<T, Widget> cases;

  /// The widget to show when [value] doesn't match any case.
  /// Defaults to an empty [SizedBox] if not provided.
  final Widget? fallback;

  const SwitchView({
    required this.value,
    required this.cases,
    this.fallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return cases[value] ?? fallback ?? const SizedBox();
  }
}
