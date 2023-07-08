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

  static m6(fieldName, format) => "${fieldName} must match the format ${format}.";

  static m7(fieldName) => "${fieldName} must be a valid date.";

  static m8(fieldName, field) => "${fieldName} must have a different value than ${field}.";

  static m9(fieldName, min, max) => "${fieldName} must have a length between ${min} and ${max}.";

  static m10(fieldName, value) => "${fieldName} must be numeric and have an exact length of ${value}.";

  static m11(fieldName) => "${fieldName} must be a valid email address.";

  static m12(fieldName) => "${fieldName} must be included in the given list of values.";

  static m13(fieldName) => "${fieldName} must be an integer.";

  static m14(fieldName, length) => "${fieldName} must not exceed ${length} characters.";

  static m15(fieldName, max) => "You may only select ${max} ${fieldName}.";

  static m16(fieldName, value) => "${fieldName} must have a maximum value of ${value}.";

  static m17(fieldName, length) => "${fieldName} must be at least ${length} characters long.";

  static m18(fieldName, min) => "You must select at least ${min} ${fieldName}.";

  static m19(fieldName, value) => "${fieldName} must have a minimum value of ${value}.";

  static m20(fieldName) => "${fieldName} must not be included in the given list of values.";

  static m21(fieldName) => "${fieldName} must be numeric.";

  static m22(fieldName, min, max) => "You must select between ${min} and ${max} ${fieldName}.";

  static m23(fieldName) => "${fieldName} must match the given pattern.";

  static m24(fieldName) => "${fieldName} is required.";

  static m25(fieldName, field) => "${fieldName} must have the same value as ${field}.";

  static m26(fieldName, value) => "${fieldName} must have a size of ${value}.";

  static m27(fieldName) => "${fieldName} must be a valid URL.";

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
