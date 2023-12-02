import 'package:fiverr/core/manager/theme/app_color.dart';
import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom({
    super.key,
    required this.label,
    this.controller,
    bool? obscureText,
    this.validator,
    this.suffix,
    this.prefix,
    this.onChanged,
    this.keyboardType,
    double? height,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.onClick,
  })  : _obscureText = obscureText ?? false,
        _height = height ?? 55;
  final String label;
  final TextEditingController? controller;
  final bool _obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;

  final double _height;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: TextFormField(
        style: const TextStyle(color: AppColor.blackColor),
        onTap: onClick,
        controller: controller,
        obscureText: _obscureText,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines ?? 1,
        maxLength: maxLength,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        validator: validator,
        onChanged: onChanged,
        autocorrect: true,
        enableSuggestions: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColor.blackColor),
          errorMaxLines: 1,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColor.blackColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColor.blackColor,
            ),
          ),
          suffixIcon: suffix,
          prefixIcon: prefix,
        ),
      ),
    );
  }
}
