import 'package:core/core.dart';
import 'package:faq/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zorg_bij_jou/providers/dev_mode_provider.dart';
import 'package:zorg_bij_jou/providers/home_page_provider.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';

import '../providers/locale_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  _onSupportQuestionClicked(BuildContext context, String slug) {
    context.go('/$supportHome/$supportQuestionRoute/$slug');
  }

  _onSupportSubjectClicked(BuildContext context, String slug) {
    context.go('/$supportHome/$supportSubjectRoute/$slug');
  }

  @override
  void initState() {
    super.initState();

    ref
        .read(homeViewModelProvider.notifier)
        .initializeFrequentlyAskedQuestions();

    ref.read(homeViewModelProvider.notifier).initializeSubjects();
  }

  @override
  Widget build(BuildContext context) {
    var locale = ref.watch(localeProvider);
    var homeViewModel = ref.watch(homeViewModelProvider);
    var isDevModeEnabled = ref.watch(devModeProvider);

    return Home(
      homeViewModel: homeViewModel,
      onSupportQuestionClicked: (slug) =>
          _onSupportQuestionClicked(context, slug),
      onSupportSubjectClicked: (slug) =>
          _onSupportSubjectClicked(context, slug),
      translationRepository: getIt(),
      selectedLocale: locale,
      onLocaleChanged: (locale) {
        customEvent('Language selected', {
          'oldLanguage': ref.read(localeProvider.notifier).state.toString(),
          'newLanguage': locale.toString()
        });
        ref.read(localeProvider.notifier).state = locale;
      },
      devModeEnabled: isDevModeEnabled,
      onDevModeEnabled: () async {
        await ref.read(devModeProvider.notifier).enableDevMode();
      },
      onDevButtonClick: () {
        GoRouter.of(context).push('/$devSettings');
      },
    );
  }
}
