import 'package:flutter/material.dart';
import 'package:flutter_upload/pages/minio.dart';
import 'package:flutter_upload/pages/strapi.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload file"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // strapi upload file
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StrapiHomePage(),
                  ),
                );
              },
              child: const Text("Strapi & Multipart form-data"),
            ),

            // S3 minio
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MinioHomePage(),
                  ),
                );
              },
              child: const Text("S3 & MiniO"),
            ),

            // cloud storage
            ElevatedButton(
              onPressed: () {},
              child: const Text("Firebase Cloud Storage"),
            ),
          ],
        ),
      ),
    );
  }
}
