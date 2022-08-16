import 'dart:convert';
import 'dart:developer';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class StrapiService {
  // TODO : change API_TOKEN here
  static String API_TOKEN =
      "b54bd1fe98895b3f3c9c3d4630e46dbead4e21adc429b415a715f8a511a2054af914b840b5b29ce3b9455ee227c8da6024f4f6234d230ec0900ae5245c9e549c8ff8d560d94e3b23410821cc44e956fbb826684248c8acad7976d3d990ae4d9aebb2fef627b0b44a99ba02075db2b80133eee1d3fe418a7fa80762f2a5cd6295";

  // TODO : change URL endpoint here
  static String endPoint = "http://192.168.1.37:1337";

  // upload file
  Map<String, String> headers = {
    "Accept": "application/json",
    "Authorization": "Bearer $API_TOKEN"
  }; // ignore this headers

  Future<String?> uploadFile({required XFile selectedImage}) async {
    // make http request
    final request = http.MultipartRequest(
      "POST",
      Uri.parse('$endPoint/api/upload'),
    );

    final stream = selectedImage.readAsBytes().asStream();
    final lenght = await selectedImage.length();

    // add file
    request.files.add(
      http.MultipartFile(
        'files',
        stream,
        lenght,
        filename: selectedImage.name,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);

    try {
      // send request
      final response = await request.send();

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        log('data= ${value}');
      });
    } catch (e) {
      log('error : ${e}');
      return null;
    }
  }
}
