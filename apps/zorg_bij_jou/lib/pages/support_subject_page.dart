import 'package:core/core.dart';
import 'package:faq/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zorg_bij_jou/providers/support_subject_page_provider.dart';

class SupportSubjectPage extends ConsumerStatefulWidget {
  final String slug;

  const SupportSubjectPage({super.key, required this.slug});

  @override
  ConsumerState<SupportSubjectPage> createState() => _SupportSubjectPageState();
}

class _SupportSubjectPageState extends ConsumerState<SupportSubjectPage> {
  @override
  void initState() {
    super.initState();

    ref
        .read(supportSubjectViewModelProvider(widget.slug).notifier)
        .initializeSubjectWithQuestions();
  }

  _onSupportQuestionClicked(BuildContext context, String slug) {
    var currentLocation =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    context.go('$currentLocation/question/$slug');
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(supportSubjectViewModelProvider(widget.slug));

    return SubjectComponent(
      viewModel: viewModel,
      translationRepository: getIt(),
      onSupportQuestionClicked: (slug) =>
          _onSupportQuestionClicked(context, slug),
    );
  }
}
