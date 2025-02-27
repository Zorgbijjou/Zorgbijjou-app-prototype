import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:theme/theme.dart';

class ScaffoldWithNestedNavigation extends StatefulWidget {
  const ScaffoldWithNestedNavigation({
    super.key,
    required this.navigationShell,
    required this.isDevMode,
    required this.isGridOverlayEnabled,
  });

  final StatefulNavigationShell navigationShell;
  final bool isDevMode;
  final bool isGridOverlayEnabled;

  @override
  State<ScaffoldWithNestedNavigation> createState() =>
      ScaffoldWithNestedNavigationState();
}

class ScaffoldWithNestedNavigationState
    extends State<ScaffoldWithNestedNavigation> {
  int selectedIndex = 0;
  final SystemUiModeManager _systemUiModeManager = getIt<SystemUiModeManager>();

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == selectedIndex,
    );

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSystemUIOverlay(context);
    });
  }

  void _updateSystemUIOverlay(BuildContext context) {
    var orientation = MediaQuery.orientationOf(context);

    var isHideStatusBar =
        orientation == Orientation.landscape && !context.isTabletView();
    if (isHideStatusBar) {
      _systemUiModeManager.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.bottom]);
    } else {
      _systemUiModeManager.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Stack(
          children: [
            widget.navigationShell,
            widget.isDevMode && widget.isGridOverlayEnabled
                ? const IgnorePointer(
                    ignoring: true,
                    child: Opacity(
                      opacity: 0.2,
                      child: ZbjGridOverlay(),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        bottomNavigationBar: ZbjNavigationBar(
          selectedIndex: selectedIndex,
          items: [
            ZbjNavigationBarItem(
              icon: CustomIcons.help_circle,
              label: AppLocalizations.of(context)!.bottomNavigationService,
              showNotificationBubble: false,
            ),
            ZbjNavigationBarItem(
              icon: CustomIcons.message_text_square_02,
              label: AppLocalizations.of(context)!.conversationTitle,
              showNotificationBubble: false,
            ),
          ],
          onDestinationSelected: _goBranch,
        ),
      );
    });
  }
}
