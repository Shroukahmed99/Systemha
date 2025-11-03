import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'text_app.dart';

enum ButtonTextWeight { bold, regular }

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.borderRadius,
    this.gradient,
    this.textColor,
    this.textAlign,
    this.isLoading = false,
    this.loadingWidth = 24,
    this.loadingHeight = 24,
    this.fontSize,
    this.fontWeight = ButtonTextWeight.bold,
    this.border,
    this.elevation,
    this.icon,
    this.padding,
    this.child,
    this.shadowColor,
  });

  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Gradient? gradient;
  final Color? textColor;
  final TextAlign? textAlign;
  final bool isLoading;
  final double loadingWidth;
  final double loadingHeight;
  final double? fontSize;
  final ButtonTextWeight fontWeight;
  final BorderSide? border;
  final double? elevation;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        gradient: gradient,
        boxShadow: [
          if (shadowColor != null)
            BoxShadow(
              color: shadowColor!,
              offset: const Offset(0, 4),
              blurRadius: 4,
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          onTap: isLoading ? null : onPressed,
          child: Align(
            alignment: Alignment.center,
            child: isLoading
                ? SizedBox(
                    width: loadingWidth,
                    height: loadingHeight,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : child ??
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center, // ✅ النص في النص عموديًا
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          icon!,
                          SizedBox(width: 8.w),
                        ],
                        TextApp(
                          text: text,
                          weight: fontWeight == ButtonTextWeight.bold
                              ? AppTextWeight.bold
                              : AppTextWeight.regular,
                          color: textColor ?? Colors.white,
                          fontSize: fontSize ?? 16.sp,
                          textAlign: textAlign ?? TextAlign.center,
                          overflow: TextOverflow.visible,
                          softWrap: false,
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
