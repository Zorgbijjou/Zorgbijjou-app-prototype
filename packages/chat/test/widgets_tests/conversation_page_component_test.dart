import 'package:chat/chat.dart';
import 'package:core/l10n/core_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/assets/icons/custom_icons.dart';

import '../helpers.dart';

void main() {
  testWidgets(
      'ConversationPageComponent should display header and go back after back button click',
      (WidgetTester tester) async {
    bool clickedBack = false;
    ConversationViewModel viewModel = ConversationViewModel(
      conversationId: '1',
      conversation: mockConversation,
      isLoading: false,
      error: null,
    );

    // Act
    await tester.pumpWidget(materialAppWithTokens(
      child: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: ConversationPageComponent(
          viewModel: viewModel,
          onBackClicked: (BuildContext context) {
            clickedBack = true;
          },
          onMessageSendClicked: (BuildContext context, String message) {},
        ),
      ),
    ));
    expect(find.text('Zorgbijjou'), findsOneWidget);
    expect(find.byType(AvatarComponent), findsOneWidget);

    var backButtonFinder = find.byIcon(CustomIcons.arrow_left);
    await tester.tap(backButtonFinder);

    // Assert
    expect(clickedBack, true);
  });
}
