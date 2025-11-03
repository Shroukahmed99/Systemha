import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:systemha/core/style/app_images.dart';
import 'package:systemha/core/style/colors.dart';
import 'package:systemha/features/auth/Presentation/manager/upload%20image/upload_image_cubit.dart';
import 'package:systemha/features/auth/Presentation/manager/upload%20image/upload_image_state.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UploadImageCubit(),
      child: BlocBuilder<UploadImageCubit, UploadImageState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => context.read<UploadImageCubit>().pickImage(),
            child: SizedBox(
              width: 116.w,
              height: 116.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(20, 153, 206, 0.35),
                          AppColors.primaryColor,
                        ],
                      ).createShader(bounds);
                    },
                    child: Container(
                      width: 116.w,
                      height: 116.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(116.w),
                    child: state.image != null
                        ? Image.file(
                            state.image!,
                            width: 116.w,
                            height: 116.w,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            AppImages.camera,
                            width: 90.w,
                            height: 50.w,
                            fit: BoxFit.contain,
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
