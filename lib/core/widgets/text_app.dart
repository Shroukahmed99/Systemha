import 'package:flutter/material.dart';
import 'package:systemha/core/style/app_text_styles.dart';

enum AppTextWeight { bold, regular }

class TextApp extends StatelessWidget {
  final String text;
  final AppTextWeight weight;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final double? height;
  final List<Shadow>? shadow;   

  const TextApp({
    super.key,
    required this.text,
    this.weight = AppTextWeight.regular,
    this.color,
    this.fontSize,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textAlign,
    this.letterSpacing,
    this.height,
    this.shadow, 
  });

  @override
  Widget build(BuildContext context) {
    TextStyle baseStyle = weight == AppTextWeight.bold
        ? AppTextStyles.bold
        : AppTextStyles.regular;

    baseStyle = baseStyle.copyWith(
      color: color ?? Colors.black,
      fontSize: fontSize,
      height: height ?? 1.0,
      letterSpacing: letterSpacing,
      shadows: shadow,
    );

    return Text(
      text,
      style: baseStyle,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      textAlign: textAlign,
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
        applyHeightToLastDescent: false,
      ),
      strutStyle: StrutStyle(
        forceStrutHeight: true,
        height: baseStyle.height ?? 1.0,
        fontSize: baseStyle.fontSize,
      ),
    );
  }
}
