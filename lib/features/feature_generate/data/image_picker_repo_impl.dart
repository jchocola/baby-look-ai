import 'package:baby_look/features/feature_generate/domain/image_picker_repository.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerRepoImpl implements ImagePickerRepository {
  final ImagePicker imagePicker = ImagePicker();

  @override
  Future<XFile?> pickImageFromCamera() async {
    final XFile? photo = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    return photo;
  }

  @override
  Future<XFile?> pickImageFromGallery() async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    return image;
  }
}
