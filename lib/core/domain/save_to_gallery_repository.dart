import 'dart:typed_data';

abstract class SaveToGalleryRepository {
  Future<void> saveImageBytesToGallery({required Uint8List imageBytes});

   Future<void> saveInterImageToGallery({required String imageUrl});
}
