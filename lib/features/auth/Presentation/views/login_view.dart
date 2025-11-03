import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:systemha/core/extensions/context_extension.dart';
import 'package:systemha/core/helpers/validation_helper.dart';
import 'package:systemha/core/routes/app_routes.dart';
import 'package:systemha/core/style/app_images.dart';
import 'package:systemha/core/style/colors.dart';
import 'package:systemha/core/style/app_text_styles.dart';
import 'package:systemha/core/widgets/custom_button.dart';
import 'package:systemha/core/widgets/custom_text_field.dart';
import 'package:systemha/core/widgets/text_app.dart';
import 'package:systemha/features/auth/Presentation/manager/login/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: cubit.formKey, 
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextApp(
                              text: "Welcome back!",
                              weight: AppTextWeight.bold,
                              fontSize: 49.sp,
                              color: AppColors.black,
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 27.h),

                            CustomTextField(
                              controller: cubit.emailController,
                              hintText: "Email",
                              suffixIcon: const Icon(
                                Icons.email_sharp,
                                color: AppColors.primaryColor75,
                                size: 16,
                              ),
                              validator: ValidationHelper.validateEmail,
                            ),

                            SizedBox(height: 60.h),

                            CustomTextField(
                              controller: cubit.passwordController,
                              hintText: "Password",
                              isPassword: true,
                              validator: ValidationHelper.validatePassword,
                            ),

                            SizedBox(height: 15.h),

                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  context.pushName(AppRoutes.resetPassword);
                                },
                                child: TextApp(
                                  text: "Forget password?",
                                  color: AppColors.grey,
                                  fontSize: 19.sp,
                                  weight: AppTextWeight.bold,
                                ),
                              ),
                            ),

                            SizedBox(height: 50.h),

                            CustomButton(
                              onPressed: state is LoginLoading
                                  ? () {}
                                  : () {
                                      if (cubit.formKey.currentState!.validate()) {
                                        cubit.login(context);
                                      }

                                    },
                              text: 'Login',
                              width: 284.w,
                              height: 41.h,
                              borderRadius: 10.r,
                              fontSize: 27.sp,
                              isLoading: state is LoginLoading,
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

                            SizedBox(height: 60.h),

                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1.h,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color.fromRGBO(129, 191, 200, 0.75),
                                          Color(0xFF0A4D68),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: TextApp(
                                    text: "Login with",
                                    color: AppColors.primaryColor,
                                    fontSize: 17.sp,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1.h,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color.fromRGBO(129, 191, 200, 0.75),
                                          Color(0xFF0A4D68),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 25.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    AppImages.google,
                                    width: 57.w,
                                    height: 59.h,
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    AppImages.facebook,
                                    width: 57.w,
                                    height: 59.h,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 40.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextApp(
                                  text: "Don’t have account? ",
                                  color: AppColors.grey,
                                  fontSize: 18.sp,
                                  weight: AppTextWeight.bold,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: GestureDetector(
                                    onTap: () {
                                      context.pushName(AppRoutes.signUp);
                                    },
                                    child: TextApp(
                                      text: "Sign up",
                                      weight: AppTextWeight.bold,
                                      color: AppColors.primaryColor,
                                      fontSize: 19.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
