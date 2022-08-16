import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CloudStorageService {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadFile({required XFile selectedImage}) async {
    File file = File(selectedImage.path);
    String targetRef = "/avatar/${selectedImage.name}";

    try {
      // upload image
      await firebaseStorage.ref(targetRef).putFile(file);

      final url = await getDownloadURL(targetRef: targetRef);
      return url;
    } catch (e) {
      // cannnot upload image
      log("Error cannot upload file - " + e.toString());
      return null;
    }
  }

  Future<String> getDownloadURL({required String targetRef}) async {
    String downloadURL = await firebaseStorage.ref(targetRef).getDownloadURL();
    return downloadURL;
  }
}
