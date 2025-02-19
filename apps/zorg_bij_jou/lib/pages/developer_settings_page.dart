import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zorg_bij_jou/providers/grid_overlay_enabled_provider.dart';
import 'package:zorg_bij_jou/providers/local_auth_enabled_provider.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';

import '../providers/dev_mode_provider.dart';

class DeveloperSettingsPage extends ConsumerWidget {
  const DeveloperSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isGridOverlayEnabled = ref.watch(gridOverlayEnabledProvider);
    var isLocalAuthEnabled = ref.watch(localAuthEnabledProvider);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 24),
          PageHeader.subLevel(
            appBar: CustomAppBar(
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: 'Developer Settings',
            subtitle: 'For debugging and development purposes',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                ListItem(
                  title: 'Restart Onboarding',
                  icon: Icons.delete_outline_outlined,
                  onTap: () {
                    _onRestartOnboarding(context, ref);
                  },
                ),
                CustomDivider.standard(),
                ListItem(
                  title: 'Disable Developer Mode',
                  icon: Icons.power_settings_new_rounded,
                  onTap: () {
                    _onDisableDevMode(context, ref);
                  },
                ),
                CustomDivider.standard(),
                ListItem(
                  title:
                      '${isGridOverlayEnabled ? 'Disable' : 'Enable'} Grid Overlay',
                  icon: Icons.grid_on,
                  onTap: () {
                    _onToggleGridOverlay(context, ref);
                  },
                ),
                CustomDivider.standard(),
                ListItem(
                  title:
                      '${isLocalAuthEnabled ? 'Disable' : 'Enable'} Local Auth',
                  icon: Icons.security,
                  onTap: () {
                    _onToggleLocalAuth(context, ref);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onToggleGridOverlay(BuildContext context, WidgetRef ref) {
    ref.read(gridOverlayEnabledProvider.notifier).toggleGridOverlay();
  }

  void _onToggleLocalAuth(BuildContext context, WidgetRef ref) {
    ref.read(localAuthEnabledProvider.notifier).toggleLocalAuth();
  }

  void _onDisableDevMode(BuildContext context, WidgetRef ref) {
    _showConfirmationDialog(
      context,
      'Confirm',
      'Are you sure you want to disable developer mode?',
      () async {
        ref.read(devModeProvider.notifier).disableDevMode();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Developer mode disabled')),
        );
        GoRouter.of(context).pop();
      },
    );
  }

  void _onRestartOnboarding(BuildContext context, WidgetRef ref) {
    _showConfirmationDialog(
      context,
      'Confirm',
      'Are you sure you want to restart onboarding?',
      () async {
        LocalStorage onboardingStorage = getIt();
        await onboardingStorage.clearOnboarding();

        if (!context.mounted) {
          return;
        }

        GoRouter.of(context).go('/$onboardingRoute');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Onboarding restarted')),
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, String title,
      String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: title,
          content: content,
          onConfirm: onConfirm,
        );
      },
    );
  }
}

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
