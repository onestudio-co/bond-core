import 'dart:developer';

extension StringUtils on String {
  String get englishNumbers {
    var str = this;
    str = str.replaceAll(RegExp("٠"), "0");
    str = str.replaceAll(RegExp("١"), "1");
    str = str.replaceAll(RegExp("٢"), "2");
    str = str.replaceAll(RegExp("٣"), "3");
    str = str.replaceAll(RegExp("٤"), "4");
    str = str.replaceAll(RegExp("٥"), "5");
    str = str.replaceAll(RegExp("٦"), "6");
    str = str.replaceAll(RegExp("٧"), "7");
    str = str.replaceAll(RegExp("٨"), "8");
    str = str.replaceAll(RegExp("٩"), "9");

    return str;
  }

  String get cleanMobile {
    var str = englishNumbers;
    str = str.replaceAll(RegExp(r'[^0-9]'), '');
    try {
      if (str.isNotEmpty) {
        str = "${int.parse(str)}";
      }
    } catch (error) {
      log('cleanMobile error $error');
    }

    return str;
  }
}
