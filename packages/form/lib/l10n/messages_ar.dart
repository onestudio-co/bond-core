// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names
// ignore_for_file:always_declare_return_types

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'ar';

  static m0(fieldName) =>
      "${fieldName} قد يحتوي فقط على أحرف أبجدية رقمية، شرطات، وشرطات سفلية.";

  static m1(fieldName) =>
      "${fieldName} يجب أن يحتوي فقط على أحرف أبجدية رقمية.";

  static m2(fieldName) => "${fieldName} يجب أن يحتوي فقط على أحرف أبجدية.";

  static m3(fieldName, min, max) =>
      "${fieldName} يجب أن يكون حجمه بين ${min} و${max}.";

  static m4(fieldName) =>
      "${fieldName} يجب أن يكون منطقيا (true, false, 1, 0, \'1\', \'0\').";

  static m5(fieldName) => "لا يتطابق تأكيد ${fieldName}.";

  static m6(fieldName, after) =>
      "${fieldName} يجب أن يكون تاريخا بعد ${after}.";

  static m7(fieldName, before) =>
      "${fieldName} يجب أن يكون تاريخا قبل ${before}.";

  static m8(fieldName, format) =>
      "${fieldName} يجب أن يتوافق مع النسق ${format}.";

  static m9(fieldName) => "${fieldName} يجب أن يكون تاريخا صحيحا.";

  static m10(fieldName, field) =>
      "${fieldName} يجب أن يكون له قيمة مختلفة عن ${field}.";

  static m11(fieldName, min, max) =>
      "${fieldName} يجب أن يكون طوله بين ${min} و${max}.";

  static m12(fieldName, value) =>
      "${fieldName} يجب أن يكون رقميا وأن يكون طوله بالضبط ${value}.";

  static m13(fieldName) => "${fieldName} يجب أن يكون عنوان بريد إلكتروني صالح.";

  static m14(fieldName) => "${fieldName} يجب أن يكون ضمن القائمة المعطاة.";

  static m15(fieldName) => "${fieldName} يجب أن يكون عددا صحيحا.";

  static m16(fieldName) => "${fieldName} يجب أن يكون  غير محدد.";

  static m17(fieldName) => "${fieldName} يجب أن يكون محددا.";

  static m18(fieldName, length) =>
      "لا يجب أن يتجاوز ${fieldName} ${length} حروف.";

  static m19(fieldName, max) =>
      "لا يمكنك تحديد أكثر من ${max} خيارات لـ ${fieldName}.";

  static m20(fieldName, value) =>
      "${fieldName} يجب أن يكون لديه قيمة عليا ${value}.";

  static m21(fieldName, length) =>
      "يجب أن يكون ${fieldName} على الأقل ${length} حروف.";

  static m22(fieldName, min) => "يجب عليك تحديد ${min} خيارات لـ ${fieldName}.";

  static m23(fieldName, value) =>
      "${fieldName} يجب أن يكون لديه قيمة دنيا ${value}.";

  static m24(fieldName) => "${fieldName} يجب أن لا يكون ضمن القائمة المعطاة.";

  static m25(fieldName) => "${fieldName} يجب أن يكون رقميا.";

  static m26(fieldName, min, max) =>
      "يجب عليك تحديد بين ${min} و ${max} خيارات لـ ${fieldName}.";

  static m27(fieldName) => "${fieldName} يجب أن يطابق النمط المحدد.";

  static m28(fieldName) => "${fieldName} مطلوب.";

  static m29(fieldName, field) =>
      "${fieldName} يجب أن يكون له نفس القيمة كـ ${field}.";

  static m30(fieldName, value) => "${fieldName} يجب أن يكون حجمه ${value}.";

  static m31(fieldName) => "${fieldName} يجب أن يكون عنوان URL صالح.";

  static m32(fieldName) => "${fieldName} يجب أن يكون رقم هاتف صالح.";

  @override
  final Map<String, dynamic> messages =
      _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'alphaDashValidationMessage': m0,
        'alphaNumValidationMessage': m1,
        'alphaValidationMessage': m2,
        'betweenValidationMessage': m3,
        'booleanValidationMessage': m4,
        'confirmedValidationMessage': m5,
        'dateAfterValidationMessage': m6,
        'dateBeforeValidationMessage': m7,
        'dateFormatValidationMessage': m8,
        'dateValidationMessage': m9,
        'differentValidationMessage': m10,
        'digitsBetweenValidationMessage': m11,
        'digitsValidationMessage': m12,
        'emailValidationMessage': m13,
        'inValuesValidationMessage': m14,
        'integerValidationMessage': m15,
        'isFalseValidationMessage': m16,
        'isTrueValidationMessage': m17,
        'maxLengthValidationMessage': m18,
        'maxSelectedValidationMessage': m19,
        'maxValueValidationMessage': m20,
        'minLengthValidationMessage': m21,
        'minSelectedValidationMessage': m22,
        'minValueValidationMessage': m23,
        'notInValuesValidationMessage': m24,
        'numericValidationMessage': m25,
        'rangeSelectedValidationMessage': m26,
        'regexValidationMessage': m27,
        'requiredValidationMessage': m28,
        'sameValidationMessage': m29,
        'sizeValidationMessage': m30,
        'urlValidationMessage': m31,
        'phoneNumberValidationMessage': m32,
      };
}
