import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool enabled;
  final bool? isDense;
  final InputBorder? border;
  final Color? fillColor;
  final bool? filled;
  final void Function()? onTap;
  const InputField({
    Key? key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.isDense,
    this.border,
    this.fillColor,
    this.filled,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        border: border ?? const OutlineInputBorder(),
        enabledBorder: border,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        disabledBorder:
            border ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
        isDense: isDense,
        fillColor: fillColor,
        filled: filled,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      onTap: onTap,
    );
  }
}
