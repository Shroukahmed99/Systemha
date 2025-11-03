import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:systemha/core/extensions/context_extension.dart';
import 'package:systemha/core/routes/app_routes.dart';
import 'package:systemha/core/style/colors.dart';
import 'package:systemha/core/widgets/text_app.dart';
import 'package:systemha/core/style/app_images.dart';

class AddFingerprintView extends StatefulWidget {
  const AddFingerprintView({super.key});

  @override
  State<AddFingerprintView> createState() => _AddFingerprintViewState();
}

class _AddFingerprintViewState extends State<AddFingerprintView> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    try {
      final canCheck = await auth.canCheckBiometrics;
      setState(() {
        _canCheckBiometrics = canCheck;
      });
    } catch (e) {
      setState(() {
        _canCheckBiometrics = false;
      });
    }
  }

  Future<void> _authenticate() async {
    try {
      final authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticated = authenticated;
      });
      if (authenticated) {
        context.pushReplacementNamed(AppRoutes.login);
      }
    } catch (e) {
      setState(() {
        _isAuthenticated = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AppImages.background,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextApp(
                    text: "Add Fingerprint",
                    fontSize: 49.sp,
                    weight: AppTextWeight.bold,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 17.h),
                  GestureDetector(
                    onTap: _canCheckBiometrics ? _authenticate : null,
                    child: Icon(
                      Icons.fingerprint_rounded,
                      size: 200.w,
                      color: AppColors.accent,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: TextApp(
                      text: _canCheckBiometrics
                          ? "Place your finger on the sensor to register your fingerprint."
                          : "Biometric authentication not available.",
                      fontSize: 21.sp,
                      color: AppColors.grey,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  if (_isAuthenticated)
                    TextApp(
                      text: "Fingerprint registered successfully ",
                      fontSize: 18.sp,
                      color: Colors.green,
                      weight: AppTextWeight.bold,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
