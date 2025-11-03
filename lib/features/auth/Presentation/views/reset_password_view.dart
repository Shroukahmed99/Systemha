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
import 'package:systemha/features/auth/Presentation/manager/reset_password/reset_password_cubit.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordCubit(),
      child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
          final cubit = context.read<ResetPasswordCubit>();

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Stack(
              children: [
                
               
                // SvgPicture.asset(
                //   'assets/employee/images/background.svg',
                //   fit: BoxFit.cover,
                //   width: double.infinity,
                //   height: double.infinity,
                // ),

                SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 120.h),

                            TextApp(
                              text: "Reset password",
                              weight: AppTextWeight.bold,
                              fontSize: 45.sp,
                              color: AppColors.black,
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 80.h),

                            CustomTextField(
                              controller: cubit.emailController,
                              hintText: "Email",
                              suffixIcon: const Icon(
                                Icons.email_rounded,
                                color: AppColors.primaryColor75,
                                size: 20,
                              ),
                              validator: ValidationHelper.validateEmail,
                            ),

                            SizedBox(height: 60.h),

                            CustomButton(
                              onPressed: state is ResetPasswordLoading
                                  ? () {}
                                  : () => cubit.sendResetLink(context),
                              text: 'Send Reset Link',
                              width: 284.w,
                              height: 41.h,
                              borderRadius: 10.r,
                              fontSize: 24.sp,
                              isLoading: state is ResetPasswordLoading,
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

                            SizedBox(height: 30.h),

                            GestureDetector(
                              onTap: () {
                                context.pushReplacementNamed(AppRoutes.login);
                              },
                              child: TextApp(
                                text: "Back to Login",
                                color: AppColors.grey,
                                fontSize: 19.sp,
                                weight: AppTextWeight.bold,
                                // shadow: [
                                //   const Shadow(
                                //     offset: Offset(0, 2),
                                //     blurRadius: 2,
                                //     color: Colors.black26,
                                //   )
                                // ],
                              ),
                            ),

                            SizedBox(height: 100.h),
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
