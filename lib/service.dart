import 'package:dio_dabble/dio_base.dart';
import 'package:dio_dabble/interceptor.dart';
import 'package:dio_dabble/jwt_token.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

class Service extends GetxService {

  var counter = 1;
  void getHttp() async {
    var _dio = DioSingleton();
    final box = GetStorage();

    _dio.init(url: 'http://voidash.pythonanywhere.com');

    var data = {
      'username': 'voidash',
      'password': 'codingjokers'
    };
    
    var response = await _dio.instance.post('/login/',data:dio.FormData.fromMap(data));

    // final jwt = JwtToken.fromJSON(response.data);

    print(counter);
    if(counter == 1) {
      response.data['access'] = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYyMTA4MDEwMiwianRpIjoiMjVmNzBkMzRkNjJhNGVlNWE5NWM2MjRlZTM4MTA4NDMiLCJ1c2VyX2lkIjoxfQ.QMJizkOwRKgEfB3uKQ-iY-cg508s8g9KqIqT4PTvzLE';
      counter++;
    }
    box.write('access', response.data['access']);
    box.write('refresh', response.data['refresh']);
    _dio.instance.interceptors.add(CustomInterceptor());
    
    // _dio.instance.interceptors.add() 

    var respnse = await _dio.instance.get('/test/');
    print(respnse.data.toString());
    

  }

} 