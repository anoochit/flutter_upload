import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_upload/services/cloudstorage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseHomePage extends StatefulWidget {
  const FirebaseHomePage({Key? key}) : super(key: key);

  @override
  State<FirebaseHomePage> createState() => _FirebaseHomePageState();
}

class _FirebaseHomePageState extends State<FirebaseHomePage> {
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cloud Storage upload"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // show browse image
            (filePath != null)
                ? ClipOval(
                    child: Image.network(
                      filePath!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
                  )
                : ClipOval(
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.grey,
                    ),
                  ),

            // browse button
            ElevatedButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                final file = await imagePicker.pickImage(source: ImageSource.gallery);

                if (file != null) {
                  log('image path : ${file.path}');
                  CloudStorageService cloudStorageService = CloudStorageService();
                  final url = await cloudStorageService.uploadFile(selectedImage: file);

                  setState(() {
                    filePath = url;
                  });
                }
              },
              child: const Text("Browse..."),
            ),

            // show uploaded image
          ],
        ),
      ),
    );
  }
}
