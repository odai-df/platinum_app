import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/theme_extension.dart';

import '../data/models/faq_model.dart';
import '../logic/chat_cubit.dart';
import '../logic/chat_state.dart';
import '../logic/faq_cubit.dart';
import '../logic/faq_state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController =
  TextEditingController();

  final ScrollController scrollController =
  ScrollController();

  final List<_ConversationItem> conversation = [];

  bool realChatStarted = false;
  bool rootLoaded = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRoot();
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  // ============================================================
  // ROOT
  // ============================================================

  Future<void> _loadRoot() async {
    if (rootLoaded) return;

    rootLoaded = true;

    _addBotMessage(
      "Hello 👋\nHow can we help you today?".tr(),
    );

    await context.read<FaqCubit>().getRootFaqs();

    if (!mounted) return;

    _addFaqOptions(
      context.read<FaqCubit>().faqs,
    );
  }

  // ============================================================
  // FAQ CLICK
  // ============================================================

  Future<void> _onFaqPressed(
      FaqModel faq,
      ) async {
    // User message
    _addUserMessage(
      faq.title,
    );

    // ==========================================================
    // CATEGORY
    // ==========================================================

    if (faq.isCategory) {
      await context.read<FaqCubit>().getChildren(
        faq.id,
      );

      if (!mounted) return;

      final children = context.read<FaqCubit>().faqs;

      if (children.isNotEmpty) {
        _addBotMessage(
          "Sure 😊\nPlease choose one of the following:".tr(),
        );

        _addFaqOptions(children);
      }

      return;
    }

    // ==========================================================
    // ANSWER
    // ==========================================================

    if (faq.isAnswer) {
      final content = faq.content?.trim();

      if (content != null && content.isNotEmpty) {
        _addBotMessage(content);
      }

      _addAnswerActions();

      return;
    }

    // ==========================================================
    // HUMAN
    // ==========================================================

    if (faq.isActionHuman) {
      await _startRealChat();
    }
  }

  // ============================================================
  // BOT MESSAGE
  // ============================================================

  void _addBotMessage(
      String text,
      ) {
    if (!mounted) return;

    setState(() {
      conversation.add(
        _ConversationItem.botMessage(
          text,
        ),
      );
    });

    _scrollToBottom();
  }

  // ============================================================
  // USER MESSAGE
  // ============================================================

  void _addUserMessage(
      String text,
      ) {
    if (!mounted) return;

    setState(() {
      conversation.add(
        _ConversationItem.userMessage(
          text,
        ),
      );
    });

    _scrollToBottom();
  }

  // ============================================================
  // FAQ OPTIONS
  // ============================================================

  void _addFaqOptions(
      List<FaqModel> faqs,
      ) {
    if (!mounted || faqs.isEmpty) return;

    setState(() {
      conversation.add(
        _ConversationItem.options(
          faqs,
        ),
      );
    });

    _scrollToBottom();
  }

  // ============================================================
  // ANSWER ACTIONS
  // ============================================================

  void _addAnswerActions() {
    if (!mounted) return;

    setState(() {
      conversation.add(
        _ConversationItem.answerActions(),
      );
    });

    _scrollToBottom();
  }

  // ============================================================
  // HELPFUL
  // ============================================================

  void _helpful() {
    _addUserMessage(
      "Helpful 👍".tr(),
    );

    _addBotMessage(
      "Glad I could help! 😊".tr(),
    );

    _addGeneralActions();
  }

  // ============================================================
  // NOT HELPFUL
  // ============================================================

  void _notHelpful() {
    _addUserMessage(
      "Talk to a support agent".tr(),
    );

    _addBotMessage(
      "Of course 😊\nI'll connect you with one of our support agents.".tr(),
    );

    _startRealChat();
  }

  // ============================================================
  // GENERAL ACTIONS
  // ============================================================

  void _addGeneralActions() {
    if (!mounted) return;

    setState(() {
      conversation.add(
        _ConversationItem.generalActions(),
      );
    });

    _scrollToBottom();
  }

  // ============================================================
  // MAIN MENU
  // ============================================================

  Future<void> _mainMenu() async {
    _addUserMessage(
      "Main menu".tr(),
    );

    _addBotMessage(
      "Sure 😊\nHow can I help you?".tr(),
    );

    await context.read<FaqCubit>().getRootFaqs();

    if (!mounted) return;

    _addFaqOptions(
      context.read<FaqCubit>().faqs,
    );
  }

  // ============================================================
  // ANOTHER QUESTION
  // ============================================================

  Future<void> _anotherQuestion() async {
    _addUserMessage(
      "I have another question".tr(),
    );

    _addBotMessage(
      "Of course 😊\nWhat would you like to know?".tr(),
    );

    await context.read<FaqCubit>().getRootFaqs();

    if (!mounted) return;

    _addFaqOptions(
      context.read<FaqCubit>().faqs,
    );
  }

  // ============================================================
  // START REAL CHAT
  // ============================================================

  Future<void> _startRealChat() async {
    if (realChatStarted) return;

    _addBotMessage(
      "Please wait a moment 👋\n I'm connecting you with our support team...".tr(),
    );

    setState(() {
      realChatStarted = true;
    });

    await context.read<ChatCubit>().initChat();
  }

  // ============================================================
  // SEND MESSAGE
  // ============================================================

  void _sendMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    context.read<ChatCubit>().sendMessage(
      text,
    );

    messageController.clear();
  }

  // ============================================================
  // SCROLL
  // ============================================================

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !scrollController.hasClients) {
        return;
      }

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 350,
        ),
        curve: Curves.easeOutCubic,
      );
    });
  }

  // ============================================================
  // APP BAR
  // ============================================================

  PreferredSizeWidget _buildAppBar(
      BuildContext context,
      ) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: context.cardColor,
      centerTitle: false,
      title: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Support".tr(),
                style: TextStyle(
                  color: context.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: realChatStarted
                          ? Colors.green
                          : AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    realChatStarted
                        ? "Online".tr()
                        : "Help Center".tr(),
                    style: TextStyle(
                      color: realChatStarted
                          ? Colors.green
                          : context.subTextColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FAQ CONVERSATION
  // ============================================================

  Widget _buildFaqConversation(
      BuildContext context,
      ) {
    return BlocBuilder<FaqCubit, FaqState>(
      builder: (context, state) {
        final isInitialLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        final isChildrenLoading = state.maybeWhen(
          childrenLoading: () => true,
          orElse: () => false,
        );

        if (isInitialLoading &&
            conversation.length <= 1) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }

        return _buildConversationList(
          context,
          showTyping: isChildrenLoading,
        );
      },
    );
  }

  // ============================================================
  // CONVERSATION LIST
  // ============================================================

  Widget _buildConversationList(
      BuildContext context, {
        bool showTyping = false,
      }) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(
        14,
        18,
        14,
        24,
      ),
      itemCount: conversation.length +
          (showTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == conversation.length) {
          return _buildTypingIndicator(
            context,
          );
        }

        return _buildConversationItem(
          context,
          conversation[index],
        );
      },
    );
  }

  // ============================================================
  // CONVERSATION ITEM
  // ============================================================

  Widget _buildConversationItem(
      BuildContext context,
      _ConversationItem item,
      ) {
    switch (item.type) {
      case _ConversationType.bot:
        return _buildBotBubble(
          context,
          item.text!,
        );

      case _ConversationType.user:
        return _buildUserBubble(
          context,
          item.text!,
        );

      case _ConversationType.options:
        return _buildOptions(
          context,
          item.options!,
        );

      case _ConversationType.answerActions:
        return _buildAnswerActions(
          context,
        );

      case _ConversationType.generalActions:
        return _buildGeneralActions(
          context,
        );
    }
  }

  // ============================================================
  // BOT BUBBLE
  // ============================================================

  Widget _buildBotBubble(
      BuildContext context,
      String text,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: AppColors.primary,
              size: 19,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 310,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: context.containerColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: context.textColor,
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // USER BUBBLE
  // ============================================================

  Widget _buildUserBubble(
      BuildContext context,
      String text,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // OPTIONS
  // ============================================================

  Widget _buildOptions(
      BuildContext context,
      List<FaqModel> options,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 42,
        right: 6,
        bottom: 16,
      ),
      child: Column(
        children: options.map((faq) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _onFaqPressed(
                  faq,
                ),
                borderRadius:
                BorderRadius.circular(16),
                child: Ink(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius:
                    BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary
                          .withOpacity(.18),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColors.primary
                              .withOpacity(.08),
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                        child: Icon(
                          faq.isCategory
                              ? Icons.folder_outlined
                              : faq.isActionHuman
                              ? Icons
                              .support_agent_outlined
                              : Icons
                              .chat_bubble_outline,
                          size: 17,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          faq.title,
                          style: TextStyle(
                            color:
                            context.textColor,
                            fontSize: 13.5,
                            fontWeight:
                            FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                      ),
                      Icon(
                        Icons
                            .arrow_forward_ios_rounded,
                        size: 13,
                        color:
                        context.subTextColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ============================================================
  // ANSWER ACTIONS
  // ============================================================

  Widget _buildAnswerActions(
      BuildContext context,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 42,
        right: 6,
        bottom: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: _actionButton(
              context,
              icon: Icons.thumb_up_alt_outlined,
              label: "Helpful".tr(),
              onTap: _helpful,
              primary: false,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _actionButton(
              context,
              icon: Icons.support_agent_outlined,
              label: "Talk to agent".tr(),
              onTap: _notHelpful,
              primary: true,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // GENERAL ACTIONS
  // ============================================================

  Widget _buildGeneralActions(
      BuildContext context,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 42,
        right: 6,
        bottom: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: _actionButton(
              context,
              icon: Icons.home_outlined,
              label: "Main menu".tr(),
              onTap: _mainMenu,
              primary: false,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _actionButton(
              context,
              icon: Icons.help_outline_rounded,
              label: "Another question".tr(),
              onTap: _anotherQuestion,
              primary: true,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ACTION BUTTON
  // ============================================================

  Widget _actionButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
        required bool primary,
      }) {
    return SizedBox(
      height: 44,
      child: primary
          ? ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(
          icon,
          size: 17,
        ),
        label: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor:
          AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(13),
          ),
        ),
      )
          : OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(
          icon,
          size: 17,
        ),
        label: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor:
          context.textColor,
          side: BorderSide(
            color: context.subTextColor
                .withOpacity(.18),
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(13),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TYPING INDICATOR
  // ============================================================

  Widget _buildTypingIndicator(
      BuildContext context,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.end,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.primary
                  .withOpacity(.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: AppColors.primary,
              size: 19,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              color: context.containerColor,
              borderRadius:
              BorderRadius.circular(18),
            ),
            child: Text(
              "•••",
              style: TextStyle(
                color: context.subTextColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // REAL CHAT
  // ============================================================

  Widget _buildRealChat(
      BuildContext context,
      ) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final cubit =
        context.read<ChatCubit>();

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding:
                const EdgeInsets.fromLTRB(
                  14,
                  14,
                  14,
                  10,
                ),
                itemCount:
                cubit.messages.length,
                itemBuilder:
                    (context, index) {
                  final message =
                  cubit.messages[index];

                  final isMe =
                      message.senderType ==
                          "client";

                  return Padding(
                    padding:
                    const EdgeInsets.only(
                      bottom: 9,
                    ),
                    child: Row(
                      mainAxisAlignment:
                      isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment
                          .start,
                      children: [
                        Flexible(
                          child: Container(
                            constraints:
                            const BoxConstraints(
                              maxWidth: 310,
                            ),
                            padding:
                            const EdgeInsets
                                .symmetric(
                              horizontal: 15,
                              vertical: 11,
                            ),
                            decoration:
                            BoxDecoration(
                              color: isMe
                                  ? AppColors
                                  .primary
                                  : context
                                  .containerColor,
                              borderRadius:
                              BorderRadius
                                  .only(
                                topLeft:
                                const Radius
                                    .circular(
                                  18,
                                ),
                                topRight:
                                const Radius
                                    .circular(
                                  18,
                                ),
                                bottomLeft:
                                Radius.circular(
                                  isMe ? 18 : 5,
                                ),
                                bottomRight:
                                Radius.circular(
                                  isMe ? 5 : 18,
                                ),
                              ),
                            ),
                            child: Text(
                              message.content ??
                                  "",
                              style: TextStyle(
                                color: isMe
                                    ? Colors.white
                                    : context
                                    .textColor,
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildInput(
              context,
              cubit,
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // INPUT
  // ============================================================

  Widget _buildInput(
      BuildContext context,
      ChatCubit cubit,
      ) {
    return Container(
      color: context.cardColor,
      padding: const EdgeInsets.fromLTRB(
        10,
        8,
        10,
        8,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                constraints:
                const BoxConstraints(
                  maxHeight: 110,
                ),
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: context.bgColor,
                  borderRadius:
                  BorderRadius.circular(25),
                  border: Border.all(
                    color: context.subTextColor
                        .withOpacity(.08),
                  ),
                ),
                child: TextField(
                  controller:
                  messageController,
                  style: TextStyle(
                    color: context.textColor,
                    fontSize: 14,
                  ),
                  minLines: 1,
                  maxLines: 5,
                  textInputAction:
                  TextInputAction.newline,
                  decoration:
                  InputDecoration(
                    border: InputBorder.none,
                    hintText: "Message",
                    hintStyle: TextStyle(
                      color:
                      context.subTextColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 48,
              height: 48,
              decoration:
              const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: _sendMessage,
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is ChatError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                  ),
                ),
              );
            }
          },
        ),
        BlocListener<FaqCubit, FaqState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (message) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
              orElse: () {},
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: context.bgColor,
        appBar: _buildAppBar(context),
        body: realChatStarted
            ? _buildRealChat(context)
            : _buildFaqConversation(context),
      ),
    );
  }
}

// ============================================================================
// CONVERSATION TYPES
// ============================================================================

enum _ConversationType {
  bot,
  user,
  options,
  answerActions,
  generalActions,
}

// ============================================================================
// CONVERSATION ITEM
// ============================================================================

class _ConversationItem {
  final _ConversationType type;

  final String? text;

  final List<FaqModel>? options;

  const _ConversationItem._({
    required this.type,
    this.text,
    this.options,
  });

  factory _ConversationItem.botMessage(
      String text,
      ) {
    return _ConversationItem._(
      type: _ConversationType.bot,
      text: text,
    );
  }

  factory _ConversationItem.userMessage(
      String text,
      ) {
    return _ConversationItem._(
      type: _ConversationType.user,
      text: text,
    );
  }

  factory _ConversationItem.options(
      List<FaqModel> options,
      ) {
    return _ConversationItem._(
      type: _ConversationType.options,
      options: options,
    );
  }

  factory _ConversationItem.answerActions() {
    return const _ConversationItem._(
      type:
      _ConversationType.answerActions,
    );
  }

  factory _ConversationItem.generalActions() {
    return const _ConversationItem._(
      type:
      _ConversationType.generalActions,
    );
  }
}