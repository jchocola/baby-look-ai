import 'dart:typed_data';

abstract class SaveToGalleryRepository {
  Future<String> saveImageBytesToGallery({required Uint8List imageBytes});

  Future<String> saveInternetImageToGallery({required String imageUrl});
}
