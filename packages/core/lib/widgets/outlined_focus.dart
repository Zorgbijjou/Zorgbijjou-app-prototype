import 'package:core/shapes/dotted_border_shape.dart';
import 'package:flutter/material.dart';

class ZbjOutlinedFocus extends StatefulWidget {
  final Function(BuildContext context, bool showFocus) builder;
  final BorderRadius borderRadius;
  final FocusNode focusNode;
  final bool suppressOutlineFocus;

  const ZbjOutlinedFocus({
    super.key,
    required this.builder,
    required this.focusNode,
    this.borderRadius = const BorderRadius.all(Radius.zero),
    this.suppressOutlineFocus = false,
  });

  @override
  State<ZbjOutlinedFocus> createState() => _ZbjOutlinedFocusState();
}

class _ZbjOutlinedFocusState extends State<ZbjOutlinedFocus> {
  bool showFocus = false;

  @override
  initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {
        showFocus = widget.focusNode.hasFocus;
      });
    });

    FocusManager.instance
        .addHighlightModeListener(handleFocusHighlightModeChange);
  }

  void handleFocusHighlightModeChange(FocusHighlightMode mode) {
    if (!mounted) {
      return;
    }

    setState(() {
      updateFocusHighlights();
    });
  }

  bool get _shouldShowFocus {
    var hasFocus = widget.focusNode.hasFocus;
    return switch (MediaQuery.maybeNavigationModeOf(context)) {
      NavigationMode.traditional || null => hasFocus,
      NavigationMode.directional => hasFocus,
    };
  }

  void updateFocusHighlights() {
    bool isShowFocus = switch (FocusManager.instance.highlightMode) {
      FocusHighlightMode.touch => false,
      FocusHighlightMode.traditional => _shouldShowFocus,
    };

    setState(() {
      showFocus = isShowFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      key: const Key('outlined_focus'),
      color: Colors.transparent,
      shape: showFocus && !widget.suppressOutlineFocus
          ? ZbjDottedBorderShape.focusRing(
              context,
              borderRadius: widget.borderRadius,
            )
          : null,
      child: Builder(
        builder: (context) => widget.builder(context, showFocus),
      ),
    );
  }
}
