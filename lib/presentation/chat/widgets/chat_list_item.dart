import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/constants/colors.dart';

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
    return GestureDetector(
      onTap: () {
        context.go(
          '/chat/$chatId',
        ); // api 연결시 바꿀 예정
      },
      child: Container(
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
            const SizedBox(width: 10),
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
                  const SizedBox(height: 5),
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
                    const SizedBox(width: 5),
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
                const SizedBox(height: 5),
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
      ),
    );
  }
}
