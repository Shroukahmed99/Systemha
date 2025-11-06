import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
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
    _initBiometric();
  }

  Future<void> _initBiometric() async {
    await _checkDeviceSupport();
    await _checkBiometrics();
  }

  Future<void> _checkDeviceSupport() async {
    try {
      final isSupported = await auth.isDeviceSupported();
      print("Device supports biometrics: $isSupported");
      if (!isSupported) {
        setState(() => _canCheckBiometrics = false);
      }
    } catch (e) {
      print("Error checking device support: $e");
    }
  }

  Future<void> _checkBiometrics() async {
    try {
      final canCheck = await auth.canCheckBiometrics;
      final available = await auth.getAvailableBiometrics();
      print("Can check biometrics: $canCheck");
      print("Available biometrics: $available");
      setState(() {
        _canCheckBiometrics = canCheck && available.isNotEmpty;
      });
    } catch (e) {
      print("Error checking biometrics: $e");
      setState(() {
        _canCheckBiometrics = false;
      });
    }
  }

  Future<void> _authenticate() async {
    try {
      print("Starting fingerprint authentication...");
      final authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      setState(() {
        _isAuthenticated = authenticated;
      });

      print("Authenticated: $authenticated");

      if (authenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Fingerprint registered successfully ✅")),
        );
        // Navigate to login
        context.pushReplacementNamed(AppRoutes.login);
      }
    } catch (e) {
      print("Auth error: $e");
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
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextApp(
                    text: "Add Fingerprint",
                    fontSize: 48.sp,
                    weight: AppTextWeight.bold,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: _canCheckBiometrics ? _authenticate : null,
                    child: Icon(
                      Icons.fingerprint_rounded,
                      size: 180.w,
                      color: _canCheckBiometrics
                          ? AppColors.accent
                          : AppColors.grey,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: TextApp(
                      text: _canCheckBiometrics
                          ? "Place your finger on the sensor to register your fingerprint."
                          : "Biometric authentication not available on this device.",
                      fontSize: 20.sp,
                      color: AppColors.grey,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  if (_isAuthenticated)
                    TextApp(
                      text: "Fingerprint registered successfully ✅",
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
