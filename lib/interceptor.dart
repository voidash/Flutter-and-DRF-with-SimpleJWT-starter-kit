import 'package:dio/dio.dart';
import 'package:dio_dabble/dio_base.dart';
import 'package:dio_dabble/jwt_base64.dart';
import 'package:get_storage/get_storage.dart';

class CustomInterceptor extends Interceptor{ 
  var _dio = DioSingleton();

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (checkIfAccessTokenIsExpired(GetStorage().read('access'))){
      await updateAcessToken(); 
    }
    

    options.headers['authorization'] = 'Bearer ' + GetStorage().read('access');

    super.onRequest(options, handler);
  }
  
  
  bool checkIfAccessTokenIsExpired(String jwt){
    var decodedToken = jwtToJSON(jwtConvertString(jwt));
    return checkIfAccessTokenIsExpiredFromJSON(decodedToken);
  }
  
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if(err.type == DioErrorType.response){
      if(err.response.statusCode == 401){
        _dio.instance.interceptors.requestLock.lock();
        RequestOptions options = err.response.requestOptions;
        await updateAcessToken();
        _dio.instance.interceptors.requestLock.unlock();

        print(options.headers);
        options.headers['authorization'] = 'Bearer ' + GetStorage().read('access');

        final opt = new Options(
          method: options.method,
          headers: options.headers
        );

         return await _dio.instance.request<dynamic>(options.path, data: options.data, options: opt, queryParameters: options.queryParameters);
         
      }
    }else{
      print(err);
    }
    super.onError(err, handler);
  }
  
  Future updateAcessToken() async{
    var refreshData = {
      'refresh': GetStorage().read('refresh') 
    };
    //create a new dio instance
    Dio d = new Dio();
    d.options.baseUrl = _dio.instance.options.baseUrl;


    // print(_dio.instance.options.baseUrl); check if the singleton is giving samething or not
    try{
    var response = await d.post('/login/refresh/',data: refreshData);
    GetStorage().write('access', response.data['access']);

    }catch(err){
      if(err.response?.statusCode == 401){
        //logout and sorts....
      }
    }
    

    
    

  }
  

}