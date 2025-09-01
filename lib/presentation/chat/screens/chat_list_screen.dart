import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/constants/colors.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> chatList = [
      '황지훈',
      '김민수',
      '이영희',
      '박철수',
      '최지우',
      '정우성',
      '한가인',
      '이병헌',
      '송중기',
      '김태희'
    ];

    List<String> lastMessageList = [
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

    return Center(
        child: ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.push(
              '/chat/$index',
              extra: {
                'userName': chatList[index],
                'isOnline': true,
              },
            );
          },
          child: ChatListItem(
            chatName: chatList[index],
            lastMessage: lastMessageList[index],
            isOnline: true,
            lastMessageTime: DateTime.now(),
            avatarUrl: '',
            chatId: '',
            unreadMessageCount: 3,
          ),
        );
      },
    )); // api 연결시 바꿀 예정
  }
}

class ChatListAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatListAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: WispColors.deepBlue1,
      title: const Text(
        '채팅',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
          color: Colors.white,
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              hintText: '채팅방 또는 메시지 검색',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);
}

class ChatListItem extends StatelessWidget {
  final String chatName;
  final String lastMessage;
  final bool isOnline;
  final DateTime lastMessageTime;
  final String avatarUrl;
  final String chatId;
  final int unreadMessageCount;

  const ChatListItem(
      {super.key,
      required this.chatName,
      required this.lastMessage,
      required this.isOnline,
      required this.lastMessageTime,
      required this.avatarUrl,
      required this.chatId,
      required this.unreadMessageCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ), // 임시용
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Gap(5),
                Text(
                  lastMessage,
                  style: const TextStyle(
                      fontSize: 14, color: WispColors.lightSkyBlue),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    '${lastMessageTime.hour >= 12 ? '오후' : '오전'} ${(lastMessageTime.hour % 12 == 0) ? 12 : (lastMessageTime.hour % 12)}:${lastMessageTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: WispColors.lightSkyBlue,
                    ),
                  ),
                  const Gap(5),
                  if (unreadMessageCount > 0)
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.blue,
                      child: Text(
                        unreadMessageCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
              const Gap(5),
              if (isOnline)
                const Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 8,
                )
            ],
          ),
        ],
      ),
    );
  }
}
