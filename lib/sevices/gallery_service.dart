import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:promina_task/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../provider/gallery_provider.dart';

class GalleryService{
  static Future pickImage(context, {bool isByCamera = false}) async {
    final img = await ImagePicker().pickImage(source: isByCamera ? ImageSource.camera : ImageSource.gallery);
    if (img == null) return;
    uploadImage(File(img.path), context);
  }

  static Future<void> uploadImage(File file, context) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "img": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final token =Provider.of<UserProvider>(context, listen: false).getToken();
       Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio.post(
        'https://technichal.prominaagency.com/api/upload',
        data: formData);
  }

  static Future<void> getGallery(context) async {
    final uri = 'https://technichal.prominaagency.com/api/my-gallery';
    final token = Provider.of<UserProvider>(context, listen: false).getToken();
        http.Response result = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      Provider.of<GalleryProvider>(context, listen: false).setImages(jsonResponse['data']['images']);
      print(jsonResponse['data']);
      print(jsonResponse['data']['images']);
    }
  }
}