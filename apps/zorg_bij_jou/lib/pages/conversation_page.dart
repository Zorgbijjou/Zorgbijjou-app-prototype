import 'package:chat/view_models/conversation_view_model.dart';
import 'package:chat/widgets/conversation_page_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zorg_bij_jou/providers/conversation_page_provider.dart';

class ConversationPage extends ConsumerStatefulWidget {
  final String conversationId;

  const ConversationPage({
    super.key,
    required this.conversationId,
  });

  @override
  ConsumerState<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends ConsumerState<ConversationPage> {
  @override
  void initState() {
    super.initState();
  }

  _onBackClicked(BuildContext context) {
    Navigator.of(context).pop();
  }

  _onSendMessageClicked(BuildContext context, message) async {
    await ref
        .read(conversationViewModelProvider(widget.conversationId).notifier)
        .onSendMessageThenRefresh(message);
  }

  @override
  Widget build(BuildContext context) {
    ConversationViewModel viewModel =
        ref.watch(conversationViewModelProvider(widget.conversationId));

    return ConversationPageComponent(
      viewModel: viewModel,
      onBackClicked: _onBackClicked,
      onMessageSendClicked: _onSendMessageClicked,
    );
  }
}
