import 'package:image_picker/image_picker.dart';

abstract class ImagePickerRepository {
  Future<XFile?> pickImageFromGallery();
  Future<XFile?> pickImageFromCamera();
}
