import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/core/config/constants/colors.dart';

class ChatScreen extends StatelessWidget {
  final String userName;
  final bool isOnline;
  final String chatId;

  const ChatScreen({
    super.key,
    required this.userName,
    required this.isOnline,
    this.chatId = '',
  });

  @override
  Widget build(BuildContext context) {
    final List<String> messages = [
      '안녕하세요!',
      '오늘 날씨 어때요?',
      '주말에 뭐해요?',
      '프로젝트 진행 상황은 어때요?',
      '다음 주 회의 일정은 언제인가요?',
      '새로운 영화 봤어요?',
      '이번 주말에 시간 있어요?',
      '최근에 읽은 책 추천해 주세요.',
      '다음 달 여행 계획은 어떻게 되나요?',
      '새로운 음악 추천해 주세요.',
      '안녕하세요!',
      '오늘 날씨 어때요?',
      '주말에 뭐해요?',
      '프로젝트 진행 상황은 어때요?',
      '다음 주 회의 일정은 언제인가요?',
      '새로운 영화 봤어요?',
      '이번 주말에 시간 있어요?',
      '최근에 읽은 책 추천해 주세요.',
      '다음 달 여행 계획은 어떻게 되나요?',
      '새로운 음악 추천해 주세요.'
    ];

    return BaseScaffold(
      appBar: ChatAppbar(
        userName: userName,
        isOnline: isOnline,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ChatItem(
                  message: messages[index],
                  isRead: index % 2 == 0,
                  isMe: index % 2 == 0,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: messages.length,
            ),
          ),
          const ChatTextField(),
        ],
      ),
    );
  }
}

class ChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final bool isOnline;

  const ChatAppbar({
    super.key,
    required this.userName,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: WispColors.deepBlue1,
      actions: [
        IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
            ), // api 연결시 받아올 에정
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                isOnline
                    ? const Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 12,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '온라인',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ChatItem extends StatelessWidget {
  final String message;
  final bool isRead;
  final bool isMe;

  const ChatItem({
    super.key,
    required this.message,
    this.isRead = false,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          constraints: BoxConstraints(
            maxWidth: screenWidth * 0.5,
          ),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: isMe
                ? const LinearGradient(
                    colors: [Color(0xFF3D7BF6), Color(0xFF8C52FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)
                : null,
            borderRadius: BorderRadius.circular(16),
            border: isMe
                ? null
                : Border.all(
                    color: Colors.white,
                    width: 0.7,
                  ),
          ),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      '오후 12:30', // 시간은 API로부터 받아올 예정
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (isMe && isRead)
                      const Icon(
                        Icons.check,
                        size: 16,
                        color: WispColors.deepBlue3,
                      ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: WispColors.grey, width: 0.5),
        ),
        color: null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 5,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              color: WispColors.lightSkyBlue,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.attach_file,
              color: WispColors.lightSkyBlue,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                border: Border.all(color: WispColors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TextField(
                minLines: 1,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: '메시지를 입력하세요',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  hintStyle: TextStyle(
                    color: WispColors.lightSkyBlue,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bolt_outlined,
              color: Colors.yellow,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send,
              color: WispColors.lightSkyBlue,
            ),
          ),
        ],
      ),
    );
  }
}
