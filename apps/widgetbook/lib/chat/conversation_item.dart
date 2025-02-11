import 'package:chat/chat.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme/theme.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Full screen width',
    type: ConversationItemComponent,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=3228-3130&t=lg1WYn4IwgiCM15G-4',
    path: 'Chat')
Widget buildFullWidthListItemUseCase(BuildContext context) {
  var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);

  return FutureBuilder(
      future: localeDataSource.initializeLocales(['nl', 'en']),
      builder: (context, _) => Column(children: [
            Container(
              color: context.tokens.color.tokensWhite,
              child: ConversationItemComponent(
                title: context.knobs
                    .string(label: 'Title', initialValue: 'Zorg bij jou'),
                description: context.knobs.string(
                    label: 'Message',
                    initialValue:
                        'Tessa, verpleegkundige: Goedemorgen Jeroen, we zien dat je je meting hebt gemist. Wil je deze alsnog invullen. Met vriendelijke groet, Tessa.'),
                time: context.knobs.dateTime(
                    label: 'Time',
                    initialValue: DateTime.now(),
                    start: DateTime(2000),
                    end: DateTime(2026)),
                hasUnreadMessages: context.knobs
                    .boolean(label: 'Has unread messages', initialValue: false),
                semanticsLabel: (_) => '',
                onTap: () {},
              ),
            ),
            const SizedBox(height: 8),
            const Text(
                "Note: The Grid magic doesn't work in Widgetbook, paddings might be different from the actual app"),
          ]));
}
