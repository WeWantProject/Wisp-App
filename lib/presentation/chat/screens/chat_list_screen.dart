import 'package:flutter/material.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/presentation/chat/widgets/chat_list_appbar.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      appBar: ChatListAppbar(), 
      child: Center(
        child: Text(
          'Chat List Screen',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}