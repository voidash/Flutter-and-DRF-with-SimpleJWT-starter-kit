import 'package:dio_dabble/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


Future<void> main() async{
  await initServices();
  await GetStorage.init();
  runApp(MyApp());
}

Future<void> initServices() async{
  print("the service has been started");
  await Get.putAsync<Service>(() async => Service());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
            child: Center(child: TextButton(
              child: Text('Find out now'),
              onPressed: () {
                var controller = Get.find<Service>();
                controller.getHttp();
              },
            ))
          ),
      ),
    );
  }
}

