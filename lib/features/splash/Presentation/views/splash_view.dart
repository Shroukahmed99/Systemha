import 'package:flutter/material.dart';
import 'package:systemha/core/extensions/context_extension.dart';
import 'package:systemha/core/routes/app_routes.dart';
import 'package:systemha/core/style/app_images.dart';
import 'package:systemha/core/style/colors.dart';
import 'package:systemha/core/widgets/custom_button.dart';
import 'package:systemha/core/widgets/text_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScale;
  late Animation<double> _textTyping;
  late Animation<double> _buttonFade;

  final String _appName = "Systemha";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _logoScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOutBack),
    );

    _textTyping = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 0.6, curve: Curves.easeOut),
    );

    _buttonFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
context.pushReplacementNamed(AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getAnimatedText() {
    final count =
        (_textTyping.value * _appName.length).clamp(0, _appName.length).toInt();
    return _appName.substring(0, count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                
                children: [
                  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ScaleTransition(
                        scale: _logoScale,
                        child: Image.asset(
                          AppImages.logoApp,
                          width: 59.w,
                          height: 59.w,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Opacity(
                        opacity: _textTyping.value,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: TextApp(
                            text: _getAnimatedText(),
                            weight: AppTextWeight.bold,
                            color: AppColors.backgroundColor,
                            fontSize: 55.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
              
                  SizedBox(height: 233.h),
              
             FadeTransition(
  opacity: _buttonFade,
  child: CustomButton(
    onPressed: () {
context.pushReplacementNamed(AppRoutes.login);
    },
    text: 'Start',
    width: 289.w,
    height: 54.h,
    borderRadius: 10.r,
    fontSize: 40.sp,
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.lightGrey,
        AppColors.primaryColor,
      ],
      stops: [0.0, 0.8942],
    ),
    shadowColor: const Color(0xFF0C2944),
  ),
),

 SizedBox(height: 179.h),

                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
