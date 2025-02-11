import 'package:chat/chat.dart';
import 'package:chat/view_models/conversations_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zorg_bij_jou/providers/provider_extensions.dart';

import 'conversations_provider.dart';

final conversationsViewModelProvider = StateNotifierProvider.autoDispose<
    ConversationsViewModelStateNotifier,
    ConversationsViewModel>((ref) => ConversationsViewModelStateNotifier(ref));

class ConversationsViewModelStateNotifier
    extends StateNotifier<ConversationsViewModel> {
  final Ref _ref;

  ConversationsViewModelStateNotifier(this._ref)
      : super(const ConversationsViewModel(
          isLoading: true,
        )) {
    _ref.readAndListen(conversationsStateProvider, setConversations);
  }

  void setConversations(ConversationsResult conversationsResult) {
    state = state.copyWith(
      isLoading: conversationsResult.isLoading,
      error: conversationsResult.error,
      conversations: conversationsResult.conversations,
    );
  }
}
