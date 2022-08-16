import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_upload/services/strapi.dart';
import 'package:image_picker/image_picker.dart';

class StrapiHomePage extends StatefulWidget {
  const StrapiHomePage({Key? key}) : super(key: key);

  @override
  State<StrapiHomePage> createState() => _StrapiHomePageState();
}

class _StrapiHomePageState extends State<StrapiHomePage> {
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Strapi file upload"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // show browse image
            (filePath != null)
                ? ClipOval(
                    child: Image.file(
                      File(filePath!),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
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
                  StrapiService strapiService = StrapiService();
                  final x = await strapiService.uploadFile(selectedImage: file);

                  setState(() {
                    filePath = file.path;
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
