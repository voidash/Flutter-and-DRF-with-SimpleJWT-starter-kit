import 'package:dio_dabble/app/modules/LoginPage/controller.dart';
import 'package:get/get.dart';

class LoginPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginPageController>(LoginPageController());
  }
}