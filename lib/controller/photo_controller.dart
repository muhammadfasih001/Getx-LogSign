import 'dart:convert';
import 'package:get/get.dart';
import 'package:task/model/photo_model.dart';
import 'package:http/http.dart' as http;

class PhotoController extends GetxController {
  final photoModel = RxList<PhotoModel>([]);

  @override
  void onInit() {
    super.onInit();
    getApi();
  }

  Future<void> getApi() async {
    try {
      final url = Uri.https('jsonplaceholder.typicode.com', '/photos');
      final response = await http.get(url);
      print(response);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        photoModel.value =
            data.map((json) => PhotoModel.fromJson(json)).toList();
        if (photoModel.length > 200) {
          Get.snackbar(
            "Large Dataset",
            "Retrieved This is a large dataset!",
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to load data: ${response.statusCode}",
        );
        print(response.statusCode);
      }
    } catch (error) {
      Get.snackbar(
        "Error",
        "An error occurred: $error",
      );
      print(error);
    }
  }
}
