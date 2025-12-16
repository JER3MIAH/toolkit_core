import 'package:flutter/material.dart';

/// A custom dropdown selector that matches the OutlinedTextField design.
/// Features a clean outline border, label support, and a trailing widget.
class AppSelector extends StatefulWidget {
  /// The label displayed above the field.
  final String? labelText;

  /// The hint text shown when no value is selected.
  final String? hintText;

  /// Currently selected value.
  final String? value;

  /// List of selectable string items.
  final List<String> items;

  /// Callback when selection changes.
  final void Function(String?)? onChanged;

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
  State<AppSelector> createState() => _AppSelectorState();
}

class _AppSelectorState extends State<AppSelector> {
  late FocusNode _focusNode;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _cleanupDropdown();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderCol = widget.borderColor ?? colorScheme.inversePrimary;
    final focusedBorderCol = widget.focusedBorderColor ?? Colors.blue;
    final isSelected =
        widget.value != null && widget.items.contains(widget.value);

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
          height: widget.height ?? 38,
          child: CompositedTransformTarget(
            link: _layerLink,
            child: Focus(
              focusNode: _focusNode,
              onFocusChange: (_) => setState(() {}),
              child: GestureDetector(
                onTap: _toggleDropdown,
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
                          isSelected
                              ? widget.value!
                              : widget.hintText ?? 'Select...',
                          style: isSelected
                              ? widget.textStyle ??
                                    const TextStyle(fontSize: 14)
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
                        AnimatedRotation(
                          turns: _isOpen ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            Icons.expand_more,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    if (mounted) {
      setState(() => _isOpen = true);
    }
    _focusNode.requestFocus();
  }

  /// Close dropdown on user interaction. Only call this from UI callbacks.
  void _closeDropdown() {
    _cleanupDropdown();
    if (mounted) {
      setState(() => _isOpen = false);
    }
  }

  /// Clean up dropdown resources without calling setState.
  /// Safe to call from dispose() or any context.
  void _cleanupDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _closeDropdown,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 4),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: _DropdownList(
                    items: widget.items,
                    onItemSelected: (item) {
                      widget.onChanged?.call(item);
                      _closeDropdown();
                    },
                    maxHeight: 200,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownList extends StatefulWidget {
  final List<String> items;
  final Function(String) onItemSelected;
  final double maxHeight;

  const _DropdownList({
    required this.items,
    required this.onItemSelected,
    required this.maxHeight,
  });

  @override
  State<_DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<_DropdownList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: _animation.value,
            child: child,
          ),
        );
      },
      child: Container(
        constraints: BoxConstraints(maxHeight: widget.maxHeight),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.inversePrimary),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 4),
          shrinkWrap: true,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return Material(
              child: ListTile(
                onTap: () => widget.onItemSelected(item),
                title: Text(item, style: const TextStyle(fontSize: 14)),
              ),
            );
          },
        ),
      ),
    );
  }
}
