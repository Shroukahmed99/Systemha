import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:systemha/core/style/app_text_styles.dart';
import 'package:systemha/core/style/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.keyboardType,
    this.textColor,
    this.hintColor,
    this.isPassword = false,
    this.readOnly = false,
    super.key,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Color? textColor;
  final Color? hintColor;
  final bool isPassword;
  final bool readOnly;

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
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          cursorColor: AppColors.primaryColor,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: AppTextStyles.regular.fontFamily,
            color: widget.textColor ?? AppColors.black,
            height: 1,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 16.sp,
              color: widget.hintColor ?? AppColors.primaryColor,
              height: 1,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 2.h),
          ),
        ),
        if (widget.isPassword || widget.suffixIcon != null)
          Positioned(
            right: 0,
            bottom: 4,
            child: Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: widget.isPassword
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.primaryColor75,
                        size: 18,
                      ),
                    )
                  : widget.suffixIcon!,
            ),
          ),
      ],
    );
  }
}
