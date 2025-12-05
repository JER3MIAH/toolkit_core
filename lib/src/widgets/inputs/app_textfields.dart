import 'package:flutter/material.dart';
import 'package:flutter_toolkit/flutter_toolkit.dart';

class OutlinedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final double? height;
  final String? hintText, labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? topTrailingWidget;
  final int? maxLines;
  final int? minLines;
  final bool? expands;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool showTopLabel;

  const OutlinedTextField({
    super.key,
    this.controller,
    this.height,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.textStyle,
    this.hintStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.contentPadding,
    this.topTrailingWidget,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.showTopLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null && labelText!.isNotEmpty && showTopLabel)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StyledText(labelText!, fontWeight: FontWeight.w500),
              if (topTrailingWidget != null) topTrailingWidget!,
            ],
          ),
        YGap(4),
        SizedBox(
          height: height ?? 35,
          child: TextFormField(
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: validator,
            style: textStyle,
            maxLines: maxLines,
            minLines: minLines,
            expands: expands ?? false,
            readOnly: readOnly,
            onTap: onTap,
            onChanged: onChanged,
            cursorHeight: 17,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(fontSize: 13),
              hintText: hintText,
              hintStyle: hintStyle ?? TextStyle(fontSize: 12),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding:
                  contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
              enabledBorder:
                  enabledBorder ??
                  OutlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.inversePrimary),
                    borderRadius: BorderRadius.circular(8),
                  ),
              focusedBorder:
                  focusedBorder ??
                  OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
              errorBorder:
                  errorBorder ??
                  OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
              focusedErrorBorder:
                  focusedErrorBorder ??
                  OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(8),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class PlainTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final int? hintMaxLines;
  final bool isHeader;
  final bool expands;
  final int? maxlines;

  const PlainTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.hintMaxLines,
    this.isHeader = false,
    this.expands = false,
    this.maxlines,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tStyle = TextStyle(
      fontSize: isHeader ? 24 : 14,
      fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
      color: colorScheme.onSurface,
    );

    return TextField(
      style: tStyle,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      onChanged: onChanged,
      maxLines: maxlines,
      expands: expands,
      onSubmitted:
          onSubmitted ??
          (_) {
            focusNode?.unfocus();
          },
      decoration: InputDecoration(
        hintText: hintText,
        hintMaxLines:
            hintMaxLines ?? (controller.text.trim().isNotEmpty ? 1 : 3),
        hintStyle: tStyle.copyWith(color: colorScheme.onSurfaceVariant),
        border: InputBorder.none,
        isDense: true,
      ),
    );
  }
}
