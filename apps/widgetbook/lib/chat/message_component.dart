import 'dart:core';

import 'package:chat/models/message.dart';
import 'package:chat/models/user.dart';
import 'package:chat/widgets/message_component.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Message',
  type: MessageComponent,
  path: 'Chat',
)
Widget buildMessageUseCase(BuildContext context) {
  Message message = Message(
    text: context.knobs.string(
        maxLines: 5,
        label: 'Message',
        initialValue:
            'Goedemorgen Jeroen, Ik ben verpleegkundige Tessa. Ik zie dat de meting van drie dagen geleden nog niet is ingevuld.'),
    isSystemMessage:
        context.knobs.boolean(label: 'System Message', initialValue: false),
    user: User(
      type: context.knobs
          .list(
              label: 'User Type',
              options: [
                (label: 'Practitioner', value: 'practitioner'),
                (label: 'Patient', value: 'patient'),
              ],
              labelBuilder: (item) => item.label)
          .value,
      name: context.knobs.string(label: 'Name', initialValue: 'Dr. Smith'),
    ),
    sentAt: context.knobs.dateTime(
      label: 'Message Sent At',
      initialValue: DateTime.now(),
      start: DateTime(2000),
      end: DateTime(2026),
    ),
  );

  return MessageComponent(
    message: message,
    isFirstMessage: context.knobs
        .boolean(label: 'First of multiple Messages', initialValue: true),
    conversationTitle: '',
  );
}
