import 'package:flutter/material.dart';

import 'Styles.dart';

class AppTexts {
  final String text;
  final BuildContext context;

  AppTexts({required this.context, required this.text});

  Text get textWhiteColor_w500_42 {
    return Text(text, style: Styles(context: context).textWhiteColor_w500_42);
  }

  Text get textWhiteColor_w500_38 {
    return Text(text, style: Styles(context: context).textWhiteColor_w500_38);
  }

  Text get textWhiteColor_w500_32 {
    return Text(text, style: Styles(context: context).textWhiteColor_w500_32);
  }
}