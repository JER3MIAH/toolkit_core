import 'package:flutter/material.dart';

/// A custom dropdown selector that matches the OutlinedTextField design.
/// Features a clean outline border, label support, and a trailing widget.
class AppSelector<T> extends StatefulWidget {
  /// The label displayed above the field.
  final String? labelText;

  /// The hint text shown when no value is selected.
  final String? hintText;

  /// Currently selected value.
  final T? value;

  /// List of selectable items.
  final List<AppSelectorItem<T>> items;

  /// Callback when selection changes.
  final void Function(T?)? onChanged;

  /// Widget displayed at the trailing end (e.g., dropdown icon).
  final Widget? trailingWidget;

  /// Border color when field is enabled.
  final Color? borderColor;

  /// Border color when field is focused.
  final Color? focusedBorderColor;

  /// Height of the selector field.
  final double? height;

  /// Content padding.
  final EdgeInsetsGeometry? contentPadding;

  /// Text style.
  final TextStyle? textStyle;

  /// Label text style.
  final TextStyle? labelStyle;

  /// Hint text style.
  final TextStyle? hintStyle;

  /// Show label at the top.
  final bool showTopLabel;

  const AppSelector({
    super.key,
    this.labelText,
    this.hintText,
    this.value,
    required this.items,
    this.onChanged,
    this.trailingWidget,
    this.borderColor,
    this.focusedBorderColor,
    this.height,
    this.contentPadding,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.showTopLabel = false,
  });

  @override
  State<AppSelector<T>> createState() => _AppSelectorState<T>();
}

class _AppSelectorState<T> extends State<AppSelector<T>> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderCol = widget.borderColor ?? colorScheme.inversePrimary;
    final focusedBorderCol = widget.focusedBorderColor ?? Colors.blue;
    final selectedItem = widget.items.firstWhere(
      (item) => item.value == widget.value,
      orElse: () => AppSelectorItem<T>(value: null, label: ''),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null &&
            widget.labelText!.isNotEmpty &&
            widget.showTopLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.labelText!,
              style:
                  widget.labelStyle ??
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        SizedBox(
          height: widget.height ?? 48,
          child: Focus(
            focusNode: _focusNode,
            onFocusChange: (_) => setState(() {}),
            child: GestureDetector(
              onTap: () => _showMenu(context),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _focusNode.hasFocus ? focusedBorderCol : borderCol,
                    width: _focusNode.hasFocus ? 2 : 1,
                  ),
                ),
                padding:
                    widget.contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedItem.value != null
                            ? selectedItem.label
                            : widget.hintText ?? 'Select...',
                        style: selectedItem.value != null
                            ? widget.textStyle ?? const TextStyle(fontSize: 14)
                            : widget.hintStyle ??
                                  TextStyle(
                                    fontSize: 14,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.trailingWidget != null)
                      widget.trailingWidget!
                    else
                      Icon(
                        Icons.expand_more,
                        color: colorScheme.onSurfaceVariant,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showMenu(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final pos = box.localToGlobal(Offset.zero);

    showMenu<T?>(
      context: context,
      position: RelativeRect.fromLTRB(
        pos.dx,
        pos.dy + (widget.height ?? 48),
        pos.dx + box.size.width,
        0,
      ),
      items: widget.items
          .map(
            (item) => PopupMenuItem<T?>(
              value: item.value,
              onTap: () {
                widget.onChanged?.call(item.value);
              },
              child: Text(item.label),
            ),
          )
          .toList(),
    );
  }
}

/// Represents a single item in the AppSelector.
class AppSelectorItem<T> {
  /// The value associated with this item.
  final T? value;

  /// The label displayed to the user.
  final String label;

  AppSelectorItem({required this.value, required this.label});
}
