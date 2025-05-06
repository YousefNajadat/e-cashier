import 'package:get/get.dart';

mixin UiHelper {

  String removeGaps(String phoneNumber) {
    return phoneNumber.removeAllWhitespace;
  }
}
