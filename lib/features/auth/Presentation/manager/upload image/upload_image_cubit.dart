import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:image_picker/image_picker.dart';
import 'package:systemha/features/auth/Presentation/manager/upload%20image/upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit() : super(const UploadImageState());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      emit(UploadImageState(image: File(image.path)));
    }
  }
}
