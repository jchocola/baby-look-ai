import 'dart:typed_data';

abstract class SaveToGalleryRepository {
  Future<void> saveImageBytesToGallery({required Uint8List imageBytes});

  Future<String> saveInternetImageToGallery({required String imageUrl});
}
