import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class UploadProfilePhoto {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickAndCompressImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null; // User canceled

      final File file = File(pickedFile.path);
      final String compressedPath = '${file.path}_compressed.jpg';

      final XFile? compressedFile =
          await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, compressedPath,
        quality: 75, // Adjust quality for compression
      );
      print(File(compressedFile!.path));
      return compressedFile != null ? File(compressedFile.path) : file;
    } catch (e) {
      print("Error picking/compressing image: $e");
      return null;
    }
  }
}
