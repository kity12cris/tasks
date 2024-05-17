import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasks/config/colors.dart';
import 'package:tasks/presentation/pages/home_page.dart';
import 'package:tasks/presentation/pages/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/routes.dart';

 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child){
        return MaterialApp(
          title: 'Tareas',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'MetaPro',
            colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.secondColorCustom),
            useMaterial3: true,
            scaffoldBackgroundColor: CustomColors.fifthColorCustom
          ),
          home: child,
        );
      },
      child: const LoginPage(),
    );
  }
}


