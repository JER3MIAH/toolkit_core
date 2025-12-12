import 'package:flutter/material.dart';
import 'package:flutter_toolkit/src/utils/utils.dart'
    show NoThumbScrollBehavior;

class AppColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final bool shouldScroll;
  final double spacing;

  const AppColumn({
    super.key,
    required this.children,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding,
    this.shouldScroll = true,
    this.spacing = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final body = Padding(
      padding:
          padding ??
          const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
      child: Column(
        spacing: spacing,
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      ),
    );
    return SafeArea(
      child: ScrollConfiguration(
        behavior: NoThumbScrollBehavior(),
        child: shouldScroll
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: body,
              )
            : body,
      ),
    );
  }
}
