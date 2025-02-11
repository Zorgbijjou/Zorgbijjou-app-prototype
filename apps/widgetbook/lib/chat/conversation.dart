import 'package:chat/mocks/mock_chat_api.dart';
import 'package:chat/view_models/conversation_view_model.dart';
import 'package:chat/widgets/conversation_component.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Conversation',
  type: ConversationComponent,
  path: 'Chat',
)
Widget buildConversationUseCase(BuildContext context) {
  var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);

  ConversationViewModel viewModel = ConversationViewModel(
    conversationId: '1',
    conversation: mockConversation,
    conversationMessages: mockConversationMessages[0],
    isLoading: context.knobs.boolean(label: 'Loading', initialValue: false),
    error: null,
  );

  return FutureBuilder(
    future: localeDataSource.initializeLocales(['nl', 'en']),
    builder: (context, _) => ConversationComponent(
      pageHeader: Container(),
      viewModel: viewModel,
      onMessageSendClicked: (conversationId, message) {},
    ),
  );
}
