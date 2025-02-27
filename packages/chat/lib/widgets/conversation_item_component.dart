import 'package:core/core.dart';
import 'package:core/datetime/datetime_extensions.dart';
import 'package:core/widgets/outlined_focus.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

import '../models/conversation.dart';

class ConversationItemComponent extends StatefulWidget {
  final String title;
  final DateTime time;
  final bool? isSelected;
  final bool hasUnreadMessages;
  final String description;
  final String Function(BuildContext) semanticsLabel;
  final VoidCallback? onTap;

  const ConversationItemComponent({
    super.key,
    required this.title,
    required this.time,
    required this.description,
    required this.hasUnreadMessages,
    required this.semanticsLabel,
    this.isSelected,
    this.onTap,
  });

  factory ConversationItemComponent.fromConversation({
    required Conversation conversation,
    bool? isSelected,
    VoidCallback? onTap,
  }) {
    return ConversationItemComponent(
      title: conversation.practitioner,
      time: conversation.lastMessage?.sentAt ?? DateTime.now(),
      description: conversation.lastMessage?.text ?? '',
      hasUnreadMessages: conversation.numberOfUnreadMessages > 0,
      semanticsLabel: _conversationSemanticsLabel(conversation),
      isSelected: isSelected,
      onTap: onTap,
    );
  }

  static String Function(BuildContext) _conversationSemanticsLabel(
      Conversation conversation) {
    if (conversation.lastMessage == null) {
      return (context) =>
          AppLocalizations.of(context)!.conversationNoMessageSemanticLabel(
            conversation.practitioner,
            conversation.numberOfUnreadMessages,
          );
    }

    return (context) => AppLocalizations.of(context)!.conversationSemanticLabel(
          conversation.practitioner,
          conversation.lastMessage!.text,
          conversation.lastMessage!.sentAt,
          conversation.lastMessage!.sentAt,
          conversation.numberOfUnreadMessages,
        );
  }

  @override
  State<ConversationItemComponent> createState() =>
      _ConversationItemComponentState();
}

class _ConversationItemComponentState extends State<ConversationItemComponent> {
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var isSelected = widget.isSelected ?? false;
    var hasUnreadMessages = widget.hasUnreadMessages;

    return Container(
      color: backgroundColor(isSelected, hasUnreadMessages),
      child: ZbjOutlinedFocus(
        focusNode: focusNode,
        builder: (context, showFocus) => Semantics(
          label: widget.semanticsLabel(context),
          selected: focusNode.hasFocus,
          button: true,
          excludeSemantics: true,
          child: InkWell(
            onTap: widget.onTap,
            highlightColor: Colors.transparent,
            splashColor: context.tokens.color.tokensTurqoise200,
            hoverColor: context.tokens.color.tokensTurqoise100,
            focusColor: context.tokens.color.tokensYellow300,
            focusNode: focusNode,
            child: ZbjGridPadding(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1, color: context.tokens.color.tokensGrey100),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildAvatarWidget(context),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 24,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildHeaderWidget(context),
                                const SizedBox(width: 16),
                                buildTimeWidget(
                                    context, isSelected, hasUnreadMessages),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          buildDescriptionWidget(
                              context, showFocus, isSelected),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildAvatarWidget(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      padding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/avatar-placeholder.png',
              package: 'chat'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: context.tokens.color.tokensGrey100),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(256),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(256),
          ),
        ),
      ),
    );
  }

  Text buildTimeWidget(
      BuildContext context, bool isSelected, bool hasUnreadMessages) {
    return Text(
      messageTime(context, widget.time),
      textAlign: TextAlign.right,
      style: context.tokens.textStyle.tokensTypographyParagraphSm.copyWith(
        fontWeight: isSelected || hasUnreadMessages
            ? FontWeight.bold
            : FontWeight.normal,
        color: headerColor(widget.hasUnreadMessages),
      ),
    );
  }

  String messageTime(BuildContext context, DateTime sentAt) {
    if (sentAt.isToday) {
      return AppLocalizations.of(context)!.conversationTime(sentAt);
    } else if (sentAt.isYesterday) {
      return AppLocalizations.of(context)!.conversationYesterday;
    }

    return AppLocalizations.of(context)!.conversationDate(sentAt);
  }

  Expanded buildHeaderWidget(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
          style:
              context.tokens.textStyle.tokensTypographyParagraphBoldMd.copyWith(
            color: headerColor(widget.hasUnreadMessages),
          ),
        ),
      ),
    );
  }

  SizedBox buildDescriptionWidget(
      BuildContext context, bool showFocus, bool selected) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        stripHtmlTagsForPreview(widget.description),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.tokens.textStyle.tokensTypographyParagraphMd.copyWith(
          color:
              descriptionColor(showFocus, selected, widget.hasUnreadMessages),
        ),
      ),
    );
  }

  Color descriptionColor(
      bool showFocus, bool selected, bool hasUnreadMessages) {
    if (showFocus) {
      return context.tokens.color.tokensGrey800;
    }

    if (selected) {
      return context.tokens.color.tokensGrey600;
    }

    if (hasUnreadMessages) {
      return context.tokens.color.tokensGrey600;
    }

    return context.tokens.color.tokensGrey500;
  }

  Color backgroundColor(bool isSelected, bool hasUnreadMessages) {
    if (isSelected) {
      return context.tokens.color.tokensGrey100;
    } else if (hasUnreadMessages) {
      return context.tokens.color.tokensTurqoise50;
    }
    return Colors.transparent;
  }

  Color headerColor(bool hasUnreadMessages) {
    if (hasUnreadMessages) {
      return context.tokens.color.tokensTurqoise600;
    }

    return context.tokens.color.tokensGrey800;
  }

  String stripHtmlTagsForPreview(String htmlString) {
    // Replace end paragraph tags with a single space
    htmlString = htmlString.replaceAll(RegExp(r'<\/p>'), ' ');

    // Remove all other HTML tags
    return htmlString.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }
}
