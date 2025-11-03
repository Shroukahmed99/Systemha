import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.controller,
    this.label,
    this.hintText,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.fillColor,
    this.textColor,
    this.borderColor,
    this.hintColor,
    this.errorColor,
    this.iconColor,
    this.filled = true,
    this.isPassword = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.borderRadius = 15,
    super.key,
  });

  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  final Color? fillColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? hintColor;
  final Color? errorColor;
  final Color? iconColor;

  final bool filled;
  final bool isPassword;
  final bool readOnly;
  final int? maxLength;
  final int maxLines;
  final double borderRadius;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      cursorColor: widget.textColor ?? Colors.black,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: widget.textColor ?? Colors.black,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() {
                  _obscureText = !_obscureText;
                }),
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: widget.iconColor ?? Colors.grey,
                ),
              )
            : widget.suffixIcon,
        filled: widget.filled,
        fillColor: widget.fillColor ?? Colors.grey.withOpacity(0.1),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: widget.hintColor ?? Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              BorderSide(color: widget.borderColor ?? Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              BorderSide(color: widget.borderColor ?? Colors.blue, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              BorderSide(color: widget.errorColor ?? Colors.red, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              BorderSide(color: widget.errorColor ?? Colors.red, width: 1.2),
        ),
      ),
    );
  }
}
