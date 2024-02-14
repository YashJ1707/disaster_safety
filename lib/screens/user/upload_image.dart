import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  final ImagePicker _picker = ImagePicker();
  late XFile? _image;
  final bool _isUploading = false;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      _image = pickedFile;
    });
  }

  // Future<void> _uploadImage() async {
  //   if (_image == null) return;

  //   setState(() {
  //     _isUploading = true;
  //   });

  //   final fileName = basename(_image!.path);
  //   final Reference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child('uploads/$fileName');

  //   await firebaseStorageRef.putFile(File(_image!.path));

  //   setState(() {
  //     _isUploading = false;
  //   });

  //   print("uploaded to firebase");
  // }

  Future<String?> uploadImageToFirebaseStorage() async {
    try {
      final fileName = path.basename(_image!.path); // Extract the file name.
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/$fileName'); // Define the storage reference.

      final uploadTask =
          await storageRef.putFile(File(_image!.path)); // Upload the file.

      if (uploadTask.state == firebase_storage.TaskState.success) {
        final downloadURL = await storageRef.getDownloadURL();
        return downloadURL; // Return the download URL.
      } else {
        return null; // Handle the error as needed.
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null; // Handle the error as needed.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Uploader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.gallery),
              child: const Text('Pick an image from gallery'),
            ),
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.camera),
              child: const Text('Take a picture'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading ? null : uploadImageToFirebaseStorage,
              child: const Text('Upload Image to Firebase Storage'),
            ),
          ],
        ),
      ),
    );
  }
}
