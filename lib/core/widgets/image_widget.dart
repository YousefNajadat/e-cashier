import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/responsive_size_helper.dart';

Widget svgWidget(BuildContext context, String image, double h, double w) {
  return SvgPicture.asset(
    image,
    placeholderBuilder: (context) => CircularProgressIndicator(),
    height: responsiveHeight(context, h),
    width: responsiveWidth(context, w),
  );
}

Widget imageWidget(BuildContext context, String image, double h, double w,
    {String? package,BoxFit? fit = BoxFit.fill}) {
  return Image.asset(
    image,
    fit: fit,
    height: responsiveHeight(context, h),
    width: responsiveWidth(context, w),
    package: package,
  );
}
