import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:wisp/core/config/constants/colors.dart';

class FormTextfield extends HookWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final IconData leadingIcon;
  final bool isPassword;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const FormTextfield({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.leadingIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.focusNode,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(isPassword);

    void togglePasswordVisibility() {
      obscureText.value = !obscureText.value;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const Gap(10),
        TextFormField(
          obscureText: obscureText.value,
          focusNode: focusNode,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            hintText: hintText,
            hintStyle: const TextStyle(color: WispColors.lightSkyBlue),
            prefixIcon: Icon(leadingIcon, color: WispColors.lightSkyBlue),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: WispColors.lightSkyBlue,
                    ),
                    onPressed: togglePasswordVisibility,
                  )
                : null,
            filled: true,
            fillColor: WispColors.grey,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
        ),
      ],
    );
  }
}
