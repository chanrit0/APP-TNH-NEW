import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BorderSide enabledBorderSide;
  final BorderSide focusedBorderSide;
  final BorderSide errorBorderSide;
  final BorderSide focusedErrorBorderSide;
  final bool? inputPass;

  const Input({
    super.key,
    this.initialValue,
    this.onChanged,
    this.validator,
    required this.hintText,
    this.hintStyle,
    this.textStyle,
    this.enabledBorderSide = const BorderSide(color: Colors.grey, width: 1.5),
    this.focusedBorderSide =
        const BorderSide(color: ColorDefaultApp1, width: 1.5),
    this.errorBorderSide = const BorderSide(color: Colors.red, width: 1.5),
    this.focusedErrorBorderSide =
        const BorderSide(color: Colors.red, width: 1.5),
    this.inputPass,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: widget.inputPass == null ? false : !isPasswordVisible,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        hintText: widget.hintText,
        hintStyle:
            widget.hintStyle ?? TextStyle(color: Colors.grey, fontSize: 18),
        enabledBorder: UnderlineInputBorder(
          borderSide: widget.enabledBorderSide,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: widget.focusedBorderSide,
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: widget.errorBorderSide,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: widget.focusedErrorBorderSide,
        ),
        suffixIcon: widget.inputPass ?? false
            ? IconButton(
                icon: isPasswordVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              )
            : null,
      ),
      style: widget.textStyle ??
          const TextStyle(color: ColorDefaultApp0, fontSize: 20),
    );
  }
}
