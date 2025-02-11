import 'package:chat/mocks/mock_chat_api.dart';
import 'package:chat/view_models/conversations_view_model.dart';
import 'package:chat/widgets/conversations_component.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Conversations',
  type: ConversationsComponent,
  path: 'Chat',
)
Widget buildConversationsUseCase(BuildContext context) {
  var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);

  ConversationsViewModel viewModel = ConversationsViewModel(
    conversations: mockConversations['123']!,
    isLoading: context.knobs.boolean(label: 'Loading', initialValue: false),
    error: null,
  );

  return FutureBuilder(
    future: localeDataSource.initializeLocales(['nl', 'en']),
    builder: (context, _) => ConversationsComponent(
      viewModel: viewModel,
      onConversationClicked: (context, conversation) {},
    ),
  );
}
