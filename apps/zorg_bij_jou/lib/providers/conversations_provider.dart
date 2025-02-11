import 'dart:async';

import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zorg_bij_jou/providers/time_providers.dart';

final conversationsStateProvider =
    StateNotifierProvider<ConversationsStateNotifier, ConversationsResult>(
        (ref) {
  var apiStateNotifier = ConversationsStateNotifier();
  apiStateNotifier.fetchData();

  var timer = ref.watch(timerFactoryProvider)(
    const Duration(minutes: 1),
    (timer) {
      apiStateNotifier.fetchData();
    },
  );

  ref.onDispose(() {
    timer.cancel();
  });

  return apiStateNotifier;
});

class ConversationsStateNotifier extends StateNotifier<ConversationsResult> {
  final ChatDataSource dataSource = getIt();
  final String fetchConversationsFailedEvent = 'fetchConversations failed';

  ConversationsStateNotifier({List<Conversation>? defaultConversations})
      : super(ConversationsResult(
          isLoading: true,
          error: null,
          conversations: defaultConversations,
        ));

  Future<void> fetchData() async {
    _fetchConversations().then((value) {
      state = value;
    });
  }

  Future<ConversationsResult> _fetchConversations() async {
    try {
      var conversations = await dataSource.fetchConversations();

      return ConversationsResult(
        isLoading: false,
        error: null,
        conversations: conversations,
      );
    } on Exception catch (e) {
      severe('fetchConversations', '$e');
      customEvent(fetchConversationsFailedEvent, {'error': '$e'});

      return ConversationsResult(
        isLoading: false,
        error: 'Failed to fetch conversations',
        conversations: null,
      );
    }
  }
}

class ConversationsResult {
  final bool isLoading;
  final String? error;
  final List<Conversation>? conversations;

  ConversationsResult({
    required this.isLoading,
    required this.error,
    required this.conversations,
  });
}
