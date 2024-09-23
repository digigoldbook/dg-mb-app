import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hintText;
  final IconData prefixIcon;
  final bool? readOnly;
  final bool? isObscureText;
  final Widget? suffix;
  final int? maxLine;
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.inputType,
    required this.hintText,
    required this.prefixIcon,
    this.readOnly,
    this.isObscureText,
    this.suffix,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF6F5F5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.black12,
        ),
      ),
      child: TextFormField(
        obscureText: isObscureText ?? false,
        keyboardType: inputType,
        controller: controller,
        readOnly: readOnly ?? false,
        maxLines: maxLine ?? 1,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.black38,
          ),
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
