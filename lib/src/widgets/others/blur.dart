import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';

/// A widget that applies a blur effect to its child.
///
/// [Blur] uses [BackdropFilter] to apply a Gaussian blur effect.
/// The intensity of the blur is controlled by the [sigma] parameter.
///
/// A higher [sigma] value produces a more blurred effect.
/// The default blur intensity is 8.
///
/// Example:
/// ```dart
/// // Default blur
/// Blur(
///   child: Container(
///     color: Colors.white.withOpacity(0.3),
///     child: Text('Blurred Text'),
///   ),
/// )
///
/// // Custom blur intensity
/// Blur(
///   sigma: 15,
///   child: YourWidget(),
/// )
/// ```
class Blur extends StatelessWidget {
  /// The widget to apply the blur effect to.
  final Widget child;

  /// The blur intensity in both horizontal and vertical directions.
  /// Higher values create a more blurred effect. Defaults to 8.
  final double sigma;

  const Blur({required this.child, this.sigma = 8, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: child,
      ),
    );
  }
}
