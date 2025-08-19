import 'package:flutter/material.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/core/config/constants/colors.dart';
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
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: const Column(
            children: [
              _QrCodeAddFriend(),
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
    return Container(
      child: Column(
        spacing: 10,
        children: [
          const Text(
            'QR 코드로 초대',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
              width: 100,
              height: 100,
              color: Colors.white,
              child: const SizedBox.shrink()), // Qr 코드로 대체 예정
          const Text(
            '친구가 이 QR 코드를 스캔하면 Wisp에 초대됩니다',
            style: TextStyle(
              fontSize: 16,
              color: WispColors.lightSkyBlue,
            ),
          )
        ],
      ),
    );
  }
}
