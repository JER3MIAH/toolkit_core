import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toolkit/flutter_toolkit.dart';

/// Outlined button widget with optional icon support.
class AppOutlinedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double fontSize;
  final double bHeight;
  final bool expanded;
  final Color? borderColor;
  final Color? textColor;
  final IconData? icon;
  final bool iconOnly;

  const AppOutlinedButton({
    super.key,
    required this.title,
    this.onTap,
    this.fontSize = 14,
    this.bHeight = 36,
    this.expanded = false,
    this.borderColor,
    this.textColor,
    this.icon,
    this.iconOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderCol = borderColor ?? AppColors.neutral200;
    final textCol = textColor ?? context.colors.onSurface;

    return ElevatedButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        onTap?.call();
      },
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: const WidgetStatePropertyAll(0),
        minimumSize: WidgetStatePropertyAll(
          expanded ? Size(double.infinity, bHeight) : null,
        ),
        fixedSize: WidgetStatePropertyAll(Size.fromHeight(bHeight)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderCol, width: 1.5),
          ),
        ),
      ),
      child: iconOnly && icon != null
          ? Icon(icon, color: textCol, size: fontSize + 2)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(icon, color: textCol, size: fontSize + 2),
                  ),
                Text(
                  title,
                  style: TextStyle(fontSize: fontSize, color: textCol),
                ),
              ],
            ),
    );
  }
}
