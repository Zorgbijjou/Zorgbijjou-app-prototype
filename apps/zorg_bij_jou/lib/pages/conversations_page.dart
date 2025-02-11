import 'package:chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:theme/theme.dart';
import 'package:zorg_bij_jou/providers/conversation_page_provider.dart';
import 'package:zorg_bij_jou/providers/conversations_page_provider.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';

class ConversationsPage extends ConsumerStatefulWidget {
  const ConversationsPage({super.key});

  @override
  ConsumerState<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends ConsumerState<ConversationsPage> {
  ValueNotifier<Conversation?> activeConversation =
      ValueNotifier<Conversation?>(null);

  StateNotifierProvider<ConversationViewModelStateNotifier,
      ConversationViewModel>? activeConversationProvider;

  @override
  void initState() {
    super.initState();

    activeConversation.addListener(() {
      _onActiveConversationChanged();
    });
  }

  @override
  void dispose() {
    activeConversation.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _onInitializeFirstConversationOnTablet();
  }

  _onActiveConversationChanged() {
    if (activeConversation.value == null) {
      return;
    }

    activeConversationProvider =
        conversationViewModelProvider(activeConversation.value!.id);

    setState(() {});
  }

  _onInitializeFirstConversationOnTablet() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.isTabletView()) {
        return;
      }

      if (activeConversation.value != null) {
        return;
      }

      var firstConversation =
          ref.read(conversationsViewModelProvider).conversations?.first;

      activeConversation.value = firstConversation;
    });
  }

  _onConversationClicked(BuildContext context, Conversation conversation) {
    context.push('/$chatConversations/${conversation.id}', extra: conversation);
  }

  _onTabletConversationClicked(
      BuildContext context, Conversation conversation) {
    activeConversation.value = conversation;
  }

  _onSendMessageClicked(BuildContext context, message) async {
    if (activeConversationProvider == null) {
      return;
    }

    await ref
        .read(activeConversationProvider!.notifier)
        .onSendMessageThenRefresh(message);
  }

  void _listenToConversationsViewModel() {
    ref.listen<ConversationsViewModel>(
      conversationsViewModelProvider,
      (previous, next) {
        if (next.conversations == null || next.conversations!.isEmpty) {
          return;
        }

        _onInitializeFirstConversationOnTablet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _listenToConversationsViewModel();

    var conversationsViewModel = ref.watch(conversationsViewModelProvider);
    var activeConversationViewModel = activeConversationProvider != null
        ? ref.watch(activeConversationProvider!)
        : null;

    return LayoutBuilder(builder: (context, constraints) {
      if (context.isTabletView()) {
        return ConversationsTabletComponent(
          conversationsViewModel: conversationsViewModel,
          activeConversationViewModel: activeConversationViewModel,
          onConversationClicked: _onTabletConversationClicked,
          onMessageSendClicked: _onSendMessageClicked,
        );
      }

      return ConversationsComponent(
        viewModel: conversationsViewModel,
        onConversationClicked: _onConversationClicked,
      );
    });
  }
}
