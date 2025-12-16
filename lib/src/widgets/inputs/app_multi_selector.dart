import 'package:flutter/material.dart';
import 'package:flutter_toolkit/src/utils/extensions/context_ext.dart';

/// A custom multi-select dropdown with checkboxes.
/// Similar to AppSelector but allows multiple selections.
/// Users can also add new items that automatically get selected.
class AppMultiSelector extends StatefulWidget {
  /// The label displayed above the field.
  final String? labelText;

  /// The hint text shown when no values are selected.
  final String? hintText;

  /// Currently selected values.
  final List<String> selectedValues;

  /// List of selectable items.
  final List<String> items;

  /// Callback when selection changes.
  final void Function(List<String>)? onChanged;

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

  /// Placeholder text for the "add new" input field. If empty, the input field won't be shown.
  final String addNewPlaceholder;

  /// Whether to show the dropdown trigger. Set to false to use only the content in a dialog.
  final bool isDropdown;

  const AppMultiSelector({
    super.key,
    this.labelText,
    this.hintText,
    required this.selectedValues,
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
    this.addNewPlaceholder = '',
    this.isDropdown = true,
  });

  @override
  State<AppMultiSelector> createState() => _AppMultiSelectorState();
}

class _AppMultiSelectorState extends State<AppMultiSelector> {
  late FocusNode _focusNode;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;
  late List<String> _items;
  late List<String> _selectedValues;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _items = List.from(widget.items);
    _selectedValues = List.from(widget.selectedValues);
  }

  @override
  void didUpdateWidget(AppMultiSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _items = List.from(widget.items);
    }
    if (oldWidget.selectedValues != widget.selectedValues) {
      _selectedValues = List.from(widget.selectedValues);
    }
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
    final focusedBorderCol =
        widget.focusedBorderColor ?? context.colors.primary;
    final hasSelections = _selectedValues.isNotEmpty;

    // If not a dropdown, show the content directly
    if (!widget.isDropdown) {
      return _MultiSelectDropdownList(
        items: _items,
        selectedValues: _selectedValues,
        onSelectionChanged: (selected) {
          setState(() => _selectedValues = selected);
          widget.onChanged?.call(selected);
        },
        onAddNew: (newItem) {
          if (newItem.isNotEmpty && !_items.contains(newItem)) {
            setState(() {
              _items.add(newItem);
              _selectedValues.add(newItem);
            });
            widget.onChanged?.call(_selectedValues);
          }
        },
        maxHeight: double.infinity,
        addNewPlaceholder: widget.addNewPlaceholder,
        isStandalone: true,
      );
    }

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
                          hasSelections
                              ? '${_selectedValues.length} selected'
                              : widget.hintText ?? 'Select...',
                          style: hasSelections
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
                  child: _MultiSelectDropdownList(
                    items: _items,
                    selectedValues: _selectedValues,
                    onSelectionChanged: (selected) {
                      setState(() => _selectedValues = selected);
                      widget.onChanged?.call(selected);
                    },
                    onAddNew: (newItem) {
                      if (newItem.isNotEmpty && !_items.contains(newItem)) {
                        setState(() {
                          _items.add(newItem);
                          _selectedValues.add(newItem);
                        });
                        widget.onChanged?.call(_selectedValues);
                      }
                    },
                    maxHeight: 300,
                    addNewPlaceholder: widget.addNewPlaceholder,
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

class _MultiSelectDropdownList extends StatefulWidget {
  final List<String> items;
  final List<String> selectedValues;
  final Function(List<String>) onSelectionChanged;
  final Function(String) onAddNew;
  final double maxHeight;
  final String addNewPlaceholder;
  final bool isStandalone;

  const _MultiSelectDropdownList({
    required this.items,
    required this.selectedValues,
    required this.onSelectionChanged,
    required this.onAddNew,
    required this.maxHeight,
    required this.addNewPlaceholder,
    this.isStandalone = false,
  });

  @override
  State<_MultiSelectDropdownList> createState() =>
      _MultiSelectDropdownListState();
}

class _MultiSelectDropdownListState extends State<_MultiSelectDropdownList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _addNewController = TextEditingController();
  late List<String> _localSelected;

  @override
  void initState() {
    super.initState();
    _localSelected = List.from(widget.selectedValues);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    if (!widget.isStandalone) {
      _controller.forward();
    } else {
      _controller.value = 1.0; // No animation for standalone
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _addNewController.dispose();
    super.dispose();
  }

  void _toggleItem(String item) {
    setState(() {
      if (_localSelected.contains(item)) {
        _localSelected.remove(item);
      } else {
        _localSelected.add(item);
      }
    });
    widget.onSelectionChanged(_localSelected);
  }

  void _addNewItem() {
    final newItem = _addNewController.text.trim();
    if (newItem.isNotEmpty) {
      widget.onAddNew(newItem);
      _addNewController.clear();
      setState(() {
        _localSelected = List.from(
          widget.selectedValues,
        ); // Sync with parent state
      });
    }
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 4),
                shrinkWrap: true,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  final isSelected = _localSelected.contains(item);

                  return Material(
                    child: CheckboxListTile(
                      value: isSelected,
                      onChanged: (_) => _toggleItem(item),
                      title: Text(item, style: const TextStyle(fontSize: 14)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      controlAffinity: ListTileControlAffinity.leading,
                      checkColor: Colors.white,
                      side: BorderSide(
                        color: colorScheme.inversePrimary,
                        width: 1.5,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (widget.addNewPlaceholder.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 35,
                        child: TextField(
                          controller: _addNewController,
                          decoration: InputDecoration(
                            hintText: widget.addNewPlaceholder,
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorScheme.inversePrimary,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorScheme.inversePrimary,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onSubmitted: (_) => _addNewItem(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: IconButton(
                        onPressed: _addNewItem,
                        icon: const Icon(Icons.add, size: 18),
                        color: context.colors.primary,
                        constraints: const BoxConstraints(minWidth: 35),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
