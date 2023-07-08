// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(
    String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'ar';

  static m0(fieldName) => "${fieldName} قد يحتوي فقط على أحرف أبجدية رقمية، شرطات، وشرطات سفلية.";

  static m1(fieldName) => "${fieldName} يجب أن يحتوي فقط على أحرف أبجدية رقمية.";

  static m2(fieldName) => "${fieldName} يجب أن يحتوي فقط على أحرف أبجدية.";

  static m3(fieldName, min, max) => "${fieldName} يجب أن يكون حجمه بين ${min} و${max}.";

  static m4(fieldName) => "${fieldName} يجب أن يكون منطقيا (true, false, 1, 0, \'1\', \'0\').";

  static m5(fieldName) => "لا يتطابق تأكيد ${fieldName}.";

  static m6(fieldName, format) => "${fieldName} يجب أن يتوافق مع النسق ${format}.";

  static m7(fieldName) => "${fieldName} يجب أن يكون تاريخا صحيحا.";

  static m8(fieldName, field) => "${fieldName} يجب أن يكون له قيمة مختلفة عن ${field}.";

  static m9(fieldName, min, max) => "${fieldName} يجب أن يكون طوله بين ${min} و${max}.";

  static m10(fieldName, value) => "${fieldName} يجب أن يكون رقميا وأن يكون طوله بالضبط ${value}.";

  static m11(fieldName) => "${fieldName} يجب أن يكون عنوان بريد إلكتروني صالح.";

  static m12(fieldName) => "${fieldName} يجب أن يكون ضمن القائمة المعطاة.";

  static m13(fieldName) => "${fieldName} يجب أن يكون عددا صحيحا.";

  static m14(fieldName, length) => "لا يجب أن يتجاوز ${fieldName} ${length} حروف.";

  static m15(fieldName, max) => "لا يمكنك تحديد أكثر من ${max} خيارات لـ ${fieldName}.";

  static m16(fieldName, value) => "${fieldName} يجب أن يكون لديه قيمة عليا ${value}.";

  static m17(fieldName, length) => "يجب أن يكون ${fieldName} على الأقل ${length} حروف.";

  static m18(fieldName, min) => "يجب عليك تحديد ${min} خيارات لـ ${fieldName}.";

  static m19(fieldName, value) => "${fieldName} يجب أن يكون لديه قيمة دنيا ${value}.";

  static m20(fieldName) => "${fieldName} يجب أن لا يكون ضمن القائمة المعطاة.";

  static m21(fieldName) => "${fieldName} يجب أن يكون رقميا.";

  static m22(fieldName, min, max) => "يجب عليك تحديد بين ${min} و ${max} خيارات لـ ${fieldName}.";

  static m23(fieldName) => "${fieldName} يجب أن يطابق النمط المحدد.";

  static m24(fieldName) => "${fieldName} مطلوب.";

  static m25(fieldName, field) => "${fieldName} يجب أن يكون له نفس القيمة كـ ${field}.";

  static m26(fieldName, value) => "${fieldName} يجب أن يكون حجمه ${value}.";

  static m27(fieldName) => "${fieldName} يجب أن يكون عنوان URL صالح.";

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'alphaDashValidationMessage': m0,
    'alphaNumValidationMessage': m1,
    'alphaValidationMessage': m2,
    'betweenValidationMessage': m3,
    'booleanValidationMessage': m4,
    'confirmedValidationMessage': m5,
    'dateFormatValidationMessage': m6,
    'dateValidationMessage': m7,
    'differentValidationMessage': m8,
    'digitsBetweenValidationMessage': m9,
    'digitsValidationMessage': m10,
    'emailValidationMessage': m11,
    'inValuesValidationMessage': m12,
    'integerValidationMessage': m13,
    'maxLengthValidationMessage': m14,
    'maxSelectedValidationMessage': m15,
    'maxValueValidationMessage': m16,
    'minLengthValidationMessage': m17,
    'minSelectedValidationMessage': m18,
    'minValueValidationMessage': m19,
    'notInValuesValidationMessage': m20,
    'numericValidationMessage': m21,
    'rangeSelectedValidationMessage': m22,
    'regexValidationMessage': m23,
    'requiredValidationMessage': m24,
    'sameValidationMessage': m25,
    'sizeValidationMessage': m26,
    'urlValidationMessage': m27
  };
}
