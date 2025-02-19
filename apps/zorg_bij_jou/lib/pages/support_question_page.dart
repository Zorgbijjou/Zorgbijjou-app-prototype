import 'package:core/core.dart';
import 'package:faq/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zorg_bij_jou/providers/support_question_page_provider.dart';

import '../routing/routing_constants.dart';

class SupportQuestionPage extends ConsumerStatefulWidget {
  final String slug;

  const SupportQuestionPage({super.key, required this.slug});

  @override
  ConsumerState<SupportQuestionPage> createState() =>
      _SupportQuestionPageState();
}

class _SupportQuestionPageState extends ConsumerState<SupportQuestionPage> {
  @override
  void initState() {
    super.initState();

    ref
        .read(supportQuestionViewModelProvider(widget.slug).notifier)
        .initializeQuestionWithContent();
  }

  @override
  void didUpdateWidget(covariant SupportQuestionPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.slug != oldWidget.slug) {
      ref
          .read(supportQuestionViewModelProvider(widget.slug).notifier)
          .initializeQuestionWithContent();
    }
  }

  _onSupportQuestionClicked(BuildContext context, String slug) {
    context.go('/$supportHome/$supportQuestionRoute/$slug');
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(supportQuestionViewModelProvider(widget.slug));

    return QuestionComponent(
      viewModel: viewModel,
      translationRepository: getIt(),
      onSupportQuestionClicked: (slug) =>
          _onSupportQuestionClicked(context, slug),
    );
  }
}
