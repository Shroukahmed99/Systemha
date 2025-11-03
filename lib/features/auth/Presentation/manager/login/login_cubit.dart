import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:systemha/core/helpers/snackbar.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      Snackbar.showError(context, message: "Please fix the errors");
      return;
    }

    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 2)); // محاكاة API

    // ✅ بعد النجاح أو الفشل
    if (emailController.text == "test@test.com" &&
        passwordController.text == "Password123") {
      Snackbar.showSuccess(context, message: "Login successful!");
      emit(LoginSuccess());
    } else {
      Snackbar.showError(context, message: "Invalid credentials");
      emit(LoginError("Invalid credentials"));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
