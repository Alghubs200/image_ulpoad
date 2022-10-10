import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  PickedFile? _pickedFile;
  PickedFile? get pickedFile => _pickedFile;
  final _picker = ImagePicker();
  Future<void> pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    update();
  }

  Future<bool> upload() async {
    update();
    bool success = false;
    http.StreamedResponse response = await updateProfile(_pickedFile);
    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String messaage = map["message"];
      success = true;
      print(message);
    } else {
      print("Error uploading image");
    }
    update();
    return success;
  }

  Future<http.StreamedResponse> updateProfile(PickedFile? data) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse('http://mvs.bslmeiyu.com/api/v1/auth/upload'));
    if (GetPlatform.isMobile && data != null) {
      File _file = File(data.path);
      request.files.add(http.MultipartFile(
          'image', _file.readAsBytes().asStream(), _file.lengthSync(),
          filename: _file.path.split('/').last));
    }
  }
}
