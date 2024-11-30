import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController{
  static HomeController get instance => Get.find();

  var selectedImagePath = "".obs;

  void getImage()async{
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile!=null) {
      selectedImagePath.value= pickedFile.path;
    } else {
      Get.snackbar('Error', 'Image Not Selected');
    }
  }
}