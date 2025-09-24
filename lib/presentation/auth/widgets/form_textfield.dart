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
  final bool isEnabled;

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
    this.isEnabled = true,
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
          style: TextStyle(
            color: isEnabled ? Colors.white : Colors.grey,
            fontSize: 16,
          ),
        ),
        const Gap(10),
        TextFormField(
          obscureText: obscureText.value,
          focusNode: focusNode,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          enabled: isEnabled,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            hintText: hintText,
            hintStyle: TextStyle(
              color: isEnabled ? WispColors.lightSkyBlue : Colors.grey.shade600,
            ),
            prefixIcon: Icon(
              leadingIcon,
              color: isEnabled ? WispColors.lightSkyBlue : Colors.grey.shade600,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: isEnabled
                          ? WispColors.lightSkyBlue
                          : Colors.grey.shade600,
                    ),
                    onPressed: isEnabled ? togglePasswordVisibility : null,
                  )
                : null,
            filled: true,
            fillColor: isEnabled ? WispColors.grey : Colors.grey.shade800,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isEnabled ? Colors.white : Colors.grey,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
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
          style: TextStyle(
            color: isEnabled ? Colors.white : Colors.grey.shade600,
          ),
          cursorColor: Colors.white,
        ),
      ],
    );
  }
}
