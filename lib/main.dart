import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/utils/assets.dart';

import 'core/routes.dart';
import 'core/di/get_di.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.routes,
      initialRoute: rsDefaultPage,
      title: appName,
      theme: ThemeData(
        fontFamily: 'FiraSans',
      ),
    );
  }
}
