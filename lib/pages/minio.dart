import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_upload/services/minio.dart';
import 'package:image_picker/image_picker.dart';

class MinioHomePage extends StatefulWidget {
  const MinioHomePage({Key? key}) : super(key: key);

  @override
  State<MinioHomePage> createState() => _MinioHomePageState();
}

class _MinioHomePageState extends State<MinioHomePage> {
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S3 file upload"),
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
                  MiniOService miniOService = MiniOService();

                  // upload file
                  final object = await miniOService.uploadFile(selectedImage: file);

                  // download file to localpath
                  miniOService.getFileUrl(filename: file.name).then((value) {
                    // repaint
                    setState(() {
                      filePath = value;
                    });
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
