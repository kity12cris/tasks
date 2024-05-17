import "package:flutter/material.dart";
import 'package:get/route_manager.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/new_account_page.dart';


routes() => [
  GetPage(
      name: "/loginpage",
      page: () => const LoginPage(),),
  GetPage(
    name: "/createaccountpage",
    page: () => const CreateAccountPage(),)
      //binding: LoginBinding()),

];
