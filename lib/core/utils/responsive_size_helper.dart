import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  //debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  //debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  //debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

/// Function to calculate responsive height based on screen dimensions.
/// It adjusts the given height proportionally to the screen size.
///
/// [value] : The target height you want.
/// [baseHeight] : The base height of the screen you're designing on (e.g., 932).
///
/// Returns a double value for the responsive height.
double responsiveHeight(BuildContext context, double value,
    {double baseHeight = 1920}) {
  double screenHeight = MediaQuery.of(context).size.height;
  return (value / baseHeight) * screenHeight;
}

/// Function to calculate responsive width based on screen dimensions.
/// It adjusts the given width proportionally to the screen size.
///
/// [value] : The target width you want.
/// [baseWidth] : The base width of the screen you're designing on (e.g., 430).
///
/// Returns a double value for the responsive width.
double responsiveWidth(BuildContext context, double value,
    {double baseWidth = 1080}) {
  double screenWidth = MediaQuery.of(context).size.width;
  return (value / baseWidth) * screenWidth;
}

double responsiveFont(BuildContext context, double value) {
  double screenWidth = MediaQuery.of(context).size.width;
  return value * (screenWidth / 3) / 100;
}
