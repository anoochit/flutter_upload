import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:minio/io.dart';
import 'package:minio/minio.dart';

class MiniOService {
  static const String endPoint = 'play.min.io';
  static const String accessKey = 'Q3AM3UQ867SPQQA43P2F';
  static const String secretKey = 'zuf+tfteSlswRu7BJ86wekitnifILbZam1KYY3TG';
  static const String bucket = 'darthdart';

  final minio = Minio(
    endPoint: endPoint,
    accessKey: accessKey,
    secretKey: secretKey,
  );

  // upload to S3
  Future<String> uploadFile({required XFile selectedImage}) async {
    final etag = await minio.fPutObject(bucket, selectedImage.name, selectedImage.path);
    log('object $etag');
    return etag;
  }

  Future<String> getFileUrl({required String filename}) async {
    //Directory tempDir = await getTemporaryDirectory();
    //await minio.fGetObject(bucket, '$filename', '${tempDir.path}/$filename');
    //return '${tempDir.path}/$filename';
    return await minio.presignedGetObject(bucket, '$filename', expires: 1000);
    //log(url);
  }
}
