// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(fieldName) => "${fieldName} may only contain alpha-numeric characters, dashes, and underscores.";

  static m1(fieldName) => "${fieldName} must contain only alpha-numeric characters.";

  static m2(fieldName) => "${fieldName} must contain only alphabetic characters.";

  static m3(fieldName, min, max) => "${fieldName} must have a size between ${min} and ${max}.";

  static m4(fieldName) => "${fieldName} must be a boolean (true, false, 1, 0, \'1\', \'0\').";

  static m5(fieldName) => "${fieldName} confirmation does not match.";

  static m6(fieldName, after) => "${fieldName} must be after ${after}.";

  static m7(fieldName, before) => "${fieldName} must be before ${before}.";

  static m8(fieldName, format) => "${fieldName} must match the format ${format}.";

  static m9(fieldName) => "${fieldName} must be a valid date.";

  static m10(fieldName, field) => "${fieldName} must have a different value than ${field}.";

  static m11(fieldName, min, max) => "${fieldName} must have a length between ${min} and ${max}.";

  static m12(fieldName, value) => "${fieldName} must be numeric and have an exact length of ${value}.";

  static m13(fieldName) => "${fieldName} must be a valid email address.";

  static m14(fieldName) => "${fieldName} must be included in the given list of values.";

  static m15(fieldName) => "${fieldName} must be an integer.";

  static m16(fieldName) => "The field ${fieldName} must be unchecked.";

  static m17(fieldName) => "The field ${fieldName} must be checked.";

  static m18(fieldName, length) => "${fieldName} must not exceed ${length} characters.";

  static m19(fieldName, max) => "You may only select ${max} ${fieldName}.";

  static m20(fieldName, value) => "${fieldName} must have a maximum value of ${value}.";

  static m21(fieldName, length) => "${fieldName} must be at least ${length} characters long.";

  static m22(fieldName, min) => "You must select at least ${min} ${fieldName}.";

  static m23(fieldName, value) => "${fieldName} must have a minimum value of ${value}.";

  static m24(fieldName) => "${fieldName} must not be included in the given list of values.";

  static m25(fieldName) => "${fieldName} must be numeric.";

  static m26(fieldName) => "${fieldName} must be a valid phone number.";

  static m27(fieldName, min, max) => "You must select between ${min} and ${max} ${fieldName}.";

  static m28(fieldName) => "${fieldName} must match the given pattern.";

  static m29(fieldName) => "${fieldName} is required.";

  static m30(fieldName, field) => "${fieldName} must have the same value as ${field}.";

  static m31(fieldName, value) => "${fieldName} must have a size of ${value}.";

  static m32(fieldName) => "${fieldName} must be a valid URL.";

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

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
    'phoneNumberValidationMessage': m26,
    'rangeSelectedValidationMessage': m27,
    'regexValidationMessage': m28,
    'requiredValidationMessage': m29,
    'sameValidationMessage': m30,
    'sizeValidationMessage': m31,
    'urlValidationMessage': m32
  };
}
