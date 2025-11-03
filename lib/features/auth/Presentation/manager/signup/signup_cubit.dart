import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit of(BuildContext context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nationalIdController = TextEditingController();
  final companyIdController = TextEditingController();
  final managerIdController = TextEditingController();

  void signUp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      emit(SignUpLoading());
      // simulate signup process
      Future.delayed(const Duration(seconds: 2), () {
        emit(SignUpSuccess());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Signed up successfully")));
      });
    }
  }
}
