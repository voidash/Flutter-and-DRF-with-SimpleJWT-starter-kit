import 'package:dio_dabble/core/utils/dio/dio_base.dart';
import 'package:dio_dabble/core/values/api_constants.dart';
import 'package:get/get.dart';

class DashboardPageController extends GetxController{

  var testApiString = 'this is dashboard'.obs;

  void performTest() async {
    var _dio = DioSingleton();
    try{
      var response = await _dio.instance.get('/test/');
      print(response.data);
      testApiString.value = response.data.toString();
    }catch(err){
      print(err);
    }

  }

}