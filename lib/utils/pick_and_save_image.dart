import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

/// Picks an image using the device's camera and saves it to the application's
/// documents directory.
///
/// This function uses the `ImagePicker` package to allow the user to capture
/// an image with the camera. If the user does not capture an image, the function
/// returns `null`. Otherwise, the captured image is saved to the application's
/// documents directory and a reference to the new file is returned.
///
/// Returns:
/// - A `File` object pointing to the saved image if an image is captured.
/// - `null` if no image is captured.
///
/// Throws:
/// - Any exceptions related to file operations or directory access.
///
/// Example usage:
/// ```dart
/// final File? savedImage = await pickAndSaveImage();
/// if (savedImage != null) {
///   print('Image saved at: ${savedImage.path}');
/// } else {
///   print('No image was captured.');
/// }
/// ```
Future<File?> pickAndSaveImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
  if (image == null) return null;
  final Directory directory = await getApplicationDocumentsDirectory();
  final String path = '${directory.path}/${image.name}';
  final File newImage = await File(image.path).copy(path);
  return newImage;
}
