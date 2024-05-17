//Según el tipo de dispositivo se obtiene los tamaños
import 'package:flutter/material.dart';

class SizeScaler {
  static const double _tabletBreakPoint = 600;
  static const double _referenceWidthPhone = 350;
  static const double _referenceHeightPhone = 650;
  static double _referenceWidthTablet = 600;
  static double _referenceHeightTablet = 900;

  //This method allows obtain the size of the smart table
  static bool isTablet(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 1000) {
      _referenceWidthTablet = 650;
      _referenceHeightTablet = 900;
    }
    return screenWidth >= _tabletBreakPoint;
  }

  static double scaleComponent(BuildContext context, double fontSize) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool _isTablet = isTablet(context);
    final double referenceWidth =
    _isTablet ? _referenceWidthTablet : _referenceWidthPhone;
    final double scaleFactor = screenWidth / referenceWidth;
    return (fontSize * scaleFactor).clamp(0.1, double.infinity);
  }
/*
  static double scaleComponentHeight(BuildContext context, double fontSize) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool _isTablet = isTablet(context);
    final double referenceHeight =
    _isTablet ? _referenceHeightTablet : _referenceWidthPhone;
    final double scaleFactor = screenHeight / referenceHeight;
    return (fontSize * scaleFactor).clamp(0.1, double.infinity);
  }*/

  double scaleWidth(BuildContext context, double fontSize) =>
      SizeScaler.scaleComponent(context, fontSize);
}
