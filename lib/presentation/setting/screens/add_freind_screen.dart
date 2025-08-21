import 'package:flutter/material.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/core/config/constants/colors.dart';
import 'package:wisp/presentation/setting/widgets/invite_card.dart';
import 'package:wisp/presentation/setting/widgets/setting_appbar.dart';

class AddFreindScreen extends StatelessWidget {
  const AddFreindScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const SettingAppbar(
        title: '친구 초대',
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: const Column(
            spacing: 20,
            children: [
              SizedBox(
                height: 20,
              ),
              _QrCodeAddFriend(),
              _InviteLinkCard(),
              _FriendCodeInput(),
            ],
          ),
        ),
      ),
    );
  }
}

class _QrCodeAddFriend extends StatelessWidget {
  const _QrCodeAddFriend();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        spacing: 20,
        children: [
          const Text(
            'QR 코드로 초대',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Container(
              width: 200,
              height: 200,
              color: Colors.white,
              child: const SizedBox.shrink()), // Qr 코드로 대체 예정
          const Text(
            '친구가 이 QR 코드를 스캔하면 Wisp에 초대됩니다',
            style: TextStyle(
              fontSize: 16,
              color: WispColors.lightSkyBlue,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

class _InviteLinkCard extends StatelessWidget {
  const _InviteLinkCard();

  @override
  Widget build(BuildContext context) {
    return InviteCard(
      title: '초대 링크 공유',
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                '내 초대 코드',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'WISP2024',
                  style: TextStyle(
                    fontSize: 16,
                    color: WispColors.lightSkyBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  WispColors.deepPurple,
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text(
                  '링크 복사',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FriendCodeInput extends StatelessWidget {
  const _FriendCodeInput();

  @override
  Widget build(BuildContext context) {
    return InviteCard(
      title: '친구 코드 입력',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          const Text(
            '친구의 초대 코드를 입력하세요',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: WispColors.lightSkyBlue,
                      width: 0.3,
                    ),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: const TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12),
                      hintText: '예: WISP2024',
                      hintStyle: TextStyle(
                        color: WispColors.lightSkyBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.green,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.person_add,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '추가',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Text(
            '친구로부터 받은 8자리 코드를 입력하세요.',
            style: TextStyle(
              fontSize: 14,
              color: WispColors.lightSkyBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
