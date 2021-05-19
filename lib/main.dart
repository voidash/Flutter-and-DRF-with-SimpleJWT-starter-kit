import 'package:dio_dabble/app/data/services/service.dart';
import 'package:dio_dabble/app/modules/LoginPage/page.dart';
import 'package:dio_dabble/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'routes/pages.dart';

Future<void> initServices() async{
  await GetStorage.init();
  await Get.putAsync<AppConfigService>(() async => AppConfigService().init());
}

Future<void> main() async{
  await initServices();
  runApp(IMS());
}


class IMS extends GetView<AppConfigService> {
  const IMS({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //later we can add splash screen too. 
      initialRoute: this.controller.isLoggedIn.value ? Routes.LOGIN: Routes.DASHBOARD,
      theme: darkThemeData,
      getPages: AppPages.getPages,
      home: LoginPage(),
    );
  }
}



