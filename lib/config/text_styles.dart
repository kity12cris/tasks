import 'package:flutter/material.dart';
import 'package:tasks/config/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//Definir el estilo de texto de forma personalizada
class AppTextStyle {
  static final TextStyle bottonRegistry = TextStyle(
      color: CustomColors.secondColorCustom,
      fontSize: 16.h,
      fontFamily: 'MetaPro',
      fontWeight: FontWeight.w300);

  static final TextStyle botonLoginGoogle = TextStyle(
    color: CustomColors.secondColorCustom,
    fontSize: 16.h,
    fontFamily: 'MetaPro',
    fontWeight: FontWeight.w800,
  );

  static final TextStyle bottonRememberPass = TextStyle(
      color: CustomColors.secondColorCustom,
      fontSize: 16.h,
      fontFamily: 'MetaPro',
      fontWeight: FontWeight.w300,
      decoration: TextDecoration.underline);

  static final TextStyle labelTitle = TextStyle(
      color: CustomColors.secondColorCustom,
      fontSize: 20.h,
      fontFamily: 'MetaPro',
      fontWeight: FontWeight.w500);
}

