import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:systemha/core/extensions/context_extension.dart';
import 'package:systemha/core/helpers/validation_helper.dart';
import 'package:systemha/core/routes/app_routes.dart';
import 'package:systemha/core/style/colors.dart';
import 'package:systemha/core/style/app_text_styles.dart';
import 'package:systemha/core/widgets/custom_button.dart';
import 'package:systemha/core/widgets/custom_text_field.dart';
import 'package:systemha/core/widgets/text_app.dart';
import 'package:systemha/core/style/app_images.dart';
import 'package:systemha/features/auth/Presentation/views/widgets/upload_image.dart';
import 'package:systemha/features/auth/presentation/manager/signup/signup_cubit.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          final cubit = SignUpCubit.of(context);

          return Scaffold(
            body: Stack(
              children: [
                SvgPicture.asset(
                  AppImages.background,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 40.h),
                            TextApp(
                              text: "Create account",
                              fontSize: 49.sp,
                              weight: AppTextWeight.bold,
                              color: AppColors.black,
                            ),
                            SizedBox(height: 25.h),
                            UploadImage(),
                            SizedBox(height: 30.h),
                            CustomTextField(
                              controller: cubit.nameController,
                              hintText: "Name",
                              suffixIcon: const Icon(Icons.person_2_rounded, color: AppColors.primaryColor75, size: 18),
                              validator: ValidationHelper.validateName,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              controller: cubit.emailController,
                              hintText: "Email",
                              suffixIcon: const Icon(Icons.email_rounded, color: AppColors.primaryColor75, size: 18),
                              validator: ValidationHelper.validateEmail,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              controller: cubit.passwordController,
                              hintText: "Password",
                              isPassword: true,
                              validator: ValidationHelper.validatePassword,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              controller: cubit.nationalIdController,
                              hintText: "National ID",
                              suffixIcon: const Icon(Icons.badge_rounded, color: AppColors.primaryColor75, size: 18),
                              validator: (v) => v!.isEmpty ? "Enter National ID" : null,
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: cubit.companyIdController,
                                    hintText: "Company ID",
                                    suffixIcon: Image.asset(
                                      AppImages.companyId,
                                      width: 18,
                                      height: 18,
                                    ),
                                    validator: (v) => v!.isEmpty ? "Enter Company ID" : null,
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: cubit.managerIdController,
                                    hintText: "Manager ID",
                                    suffixIcon: Image.asset(
                                      AppImages.managerId,
                                      width: 18,
                                      height: 18,
                                    ),
                                    validator: (v) => v!.isEmpty ? "Enter Manager ID" : null,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40.h),
                           CustomButton(
  onPressed: () {
    if (state is! SignUpLoading) {
      cubit.signUp(context);

      context.pushName(AppRoutes.addFingerPrint);
    }
  },
  text: 'Next',
  width: 284.w,
  height: 45.h,
  borderRadius: 10.r,
  fontSize: 25.sp,
  isLoading: state is SignUpLoading,
  gradient: const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.lightGrey, AppColors.primaryColor],
  ),
  shadowColor: const Color(0xFF0C2944),
),

                            SizedBox(height: 25.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(height: 1.h, color: AppColors.primaryColor75),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: TextApp(
                                    text: "Sign up with",
                                    color: AppColors.primaryColor,
                                    fontSize: 17.sp,
                                  ),
                                ),
                                Expanded(
                                  child: Container(height: 1.h, color: AppColors.primaryColor75),
                                ),
                              ],
                            ),
                            SizedBox(height: 9.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(AppImages.google, width: 55.w, height: 55.h),
                                ),
                                SizedBox(width: 20.w),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(AppImages.facebook, width: 55.w, height: 55.h),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextApp(
                                  text: "Already have account? ",
                                  color: AppColors.grey,
                                  fontSize: 18.sp,
                                  shadow: const [Shadow(offset: Offset(0, 1), blurRadius: 2, color: Color(0x66000000))],
                                  weight: AppTextWeight.bold,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.pushName(AppRoutes.login);
                                  },
                                  child: TextApp(
                                    text: "Login",
                                    weight: AppTextWeight.bold,
                                    color: AppColors.primaryColor,
                                    fontSize: 19.sp,
                                    shadow: const [Shadow(offset: Offset(0, 1), blurRadius: 2, color: Color(0x66000000))],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
