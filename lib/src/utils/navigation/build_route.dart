import 'package:flutter/material.dart';

enum TransitionType { slide, fade, scale, bounce }

PageRouteBuilder buildRoute(
  Widget page,
  RouteSettings settings, {
  TransitionType transition = TransitionType.bounce,
}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, _, _) => page,
    transitionDuration: Duration(milliseconds: 700),
    transitionsBuilder: (_, animation, secondaryAnimation, child) {
      CurvedAnimation curvedAnimation;

      switch (transition) {
        case TransitionType.bounce:
          // Elastic curve for bounce effect
          curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
          );
          return ScaleTransition(scale: curvedAnimation, child: child);

        case TransitionType.fade:
          curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          return FadeTransition(opacity: curvedAnimation, child: child);
        case TransitionType.scale:
          curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          return ScaleTransition(scale: curvedAnimation, child: child);
        default:
          curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          return SlideTransition(
            position: Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: child,
          );
      }
    },
  );
}
