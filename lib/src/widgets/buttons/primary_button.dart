import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toolkit/src/themes/themes.dart' show AppColors;

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double fontSize;
  final double bHeight;
  final bool expanded;
  final Color? color;
  final Color? textColor;

  const PrimaryButton({
    super.key,
    required this.title,
    this.onTap,
    this.fontSize = 14,
    this.bHeight = 41,
    this.expanded = false,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        onTap?.call();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          color ?? Theme.of(context).colorScheme.primary,
        ),
        elevation: const WidgetStatePropertyAll(0),
        minimumSize: WidgetStatePropertyAll(
          expanded ? Size(double.infinity, bHeight) : null,
        ),
        fixedSize: WidgetStatePropertyAll(Size.fromHeight(bHeight)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor ?? AppColors.white,
        ),
      ),
    );
  }
}
