import 'package:chat/chat.dart';
import 'package:chat/models/message.dart';
import 'package:core/core.dart';
import 'package:core/datetime/datetime_extensions.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class MessageComponent extends StatelessWidget {
  final String conversationTitle;
  final Message message;
  final bool isFirstMessage;

  const MessageComponent({
    super.key,
    required this.conversationTitle,
    required this.message,
    required this.isFirstMessage,
  });

  final double messageMaxWidth = 520;

  @override
  Widget build(BuildContext context) {
    if (message.isSystemMessage) {
      return buildSystemMessage(context, message);
    } else if (message.user?.type == 'practitioner') {
      return buildPractitionerMessage(context, message, isFirstMessage);
    } else if (message.user?.type == 'patient') {
      return buildPatientMessage(context, message);
    } else {
      return const SizedBox();
    }
  }

  Widget buildPractitionerMessage(
      BuildContext context, Message message, bool isFirstMessage) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: messageMaxWidth,
        ),
        padding: const EdgeInsets.only(right: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isFirstMessage
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child:
                        AvatarComponent.small(name: message.user?.name ?? ''),
                  )
                : const SizedBox(width: 48),
            const SizedBox(width: 8),
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: context.tokens.color.tokensWhite,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Semantics(
                  label: AppLocalizations.of(context)!
                      .conversationMessageSemanticLabel(
                    message.user?.name ?? '',
                    message.text,
                    conversationTitle,
                    message.sentAt,
                    message.sentAt,
                  ),
                  excludeSemantics: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isFirstMessage) ...[
                        Text(
                          message.user?.name ?? '',
                          style: context
                              .tokens.textStyle.tokensTypographyParagraphBoldMd
                              .copyWith(
                                  color: context.tokens.color.tokensOrange600),
                        ),
                        const SizedBox(height: 8),
                      ],
                      ZbjMarkdown(content: message.text),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(messageTime(context, message.sentAt)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPatientMessage(BuildContext context, Message message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(left: 48),
        constraints: BoxConstraints(
          maxWidth: messageMaxWidth,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: context.tokens.color.tokensTurqoise100,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Semantics(
          label: AppLocalizations.of(context)!.conversationMessageSemanticLabel(
            message.user?.name ?? '',
            message.text,
            conversationTitle,
            message.sentAt,
            message.sentAt,
          ),
          excludeSemantics: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ZbjMarkdown(content: message.text),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(messageTime(context, message.sentAt)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSystemMessage(BuildContext context, Message message) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.tokens.color.tokensYellow100,
      ),
      child: Semantics(
        label: AppLocalizations.of(context)!.conversationMessageSemanticLabel(
          AppLocalizations.of(context)!.conversationFromSystemSemanticLabel,
          message.text,
          conversationTitle,
          message.sentAt,
          message.sentAt,
        ),
        excludeSemantics: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ZbjMarkdown(content: message.text),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(messageTime(context, message.sentAt)),
            ),
          ],
        ),
      ),
    );
  }

  String messageTime(BuildContext context, DateTime sentAt) {
    if (sentAt.isToday) {
      return AppLocalizations.of(context)!.conversationTime(sentAt);
    } else if (sentAt.isYesterday) {
      return '${AppLocalizations.of(context)!.conversationYesterday}, ${AppLocalizations.of(context)!.conversationTime(sentAt)}';
    }

    return AppLocalizations.of(context)!.conversationDateTime(sentAt);
  }
}
