import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';

class CustomSearchTextField<T> extends StatelessWidget {
  final String? textLabel;
  final String? placeholder;
  final String? suffixText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final ValueChanged? onChanged;
  final FormFieldSetter? onSaved;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  const CustomSearchTextField({
    Key? key,
    this.textLabel,
    this.placeholder,
    this.suffixText,
    this.textInputType,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.textInputAction,
    this.controller,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      child: TextField(
        keyboardType: textInputType ?? TextInputType.text,
        style: Theme.of(context).textTheme.headlineSmall,
        cursorColor: Colors.black12,
        onChanged: onChanged,
        textInputAction: textInputAction,
        controller: controller,
        inputFormatters: inputFormatters, // Only numbers can be entered,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: suffixText != null
                ? Text('$suffixText',
                    style: Theme.of(context).textTheme.bodySmall)
                : null,
          ),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 10, minHeight: 10),
          prefixIcon: const Icon(
            Icons.search,
            color: colorPrimaryDefault,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: placeholder,
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.grey),
          contentPadding: const EdgeInsets.only(left: 14.0, right: 14),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: colorPrimaryDefault),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
