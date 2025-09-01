import 'package:flutter/material.dart';

class SettingDropdown extends StatefulWidget {
  final String selectedValue;
  final List<String> options;
  final ValueChanged<String?>? onChanged;

  const SettingDropdown({
    super.key,
    required this.options,
    required this.selectedValue,
    this.onChanged,
  });

  @override
  State<SettingDropdown> createState() => _SettingDropdownState();
}

class _SettingDropdownState extends State<SettingDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.blue[800], // 버튼 배경색
        borderRadius: BorderRadius.circular(8), // 둥근 모서리
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 0.5,
        ), // 테두리
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            value: widget.selectedValue,
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: Colors.blue[800], // 드롭다운 색상
            style: TextStyle(color: Colors.white, fontSize: 16),
            items: widget.options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: widget.onChanged),
      ),
    );
  }
}
