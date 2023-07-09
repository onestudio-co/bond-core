library validation_rules;

import 'package:bond_form/bond_form.dart';

export 'rules/alpha.dart';
export 'rules/alpha_dash.dart';
export 'rules/alpha_num.dart';
export 'rules/between.dart';
export 'rules/boolean.dart';
export 'rules/date.dart';
export 'rules/different.dart';
export 'rules/digits.dart';
export 'rules/digits_between.dart';
export 'rules/email.dart';
export 'rules/in_list.dart';
export 'rules/integer.dart';
export 'rules/max_length.dart';
export 'rules/max_value.dart';
export 'rules/min_length.dart';
export 'rules/min_value.dart';
export 'rules/not_in_list.dart';
export 'rules/numeric.dart';
export 'rules/regex.dart';
export 'rules/required.dart';
export 'rules/required_if.dart';
export 'rules/same.dart';
export 'rules/size.dart';
export 'rules/url.dart';
export 'rules/min_selected.dart';
export 'rules/max_selected.dart';
export 'rules/range_selected.dart';
export 'rules/date_before.dart';
export 'rules/date_after.dart';

export 'validation_rule.dart';

class Rules {
  static ValidationRule<T?> required<T>({String? message}) =>
      Required<T>(message: message);

  static ValidationRule<T?> requiredIf<T>(
          {String? otherFieldName,
          dynamic expectedValue,
          bool Function()? condition,
          String? message}) =>
      RequiredIf<T>(otherFieldName,
          expectedValue: expectedValue, message: message);

  static ValidationRule<T?> different<T>(String otherField,
          {String? message}) =>
      Different<T>(otherField, message: message);

  static ValidationRule<String> alpha({String? message}) =>
      Alpha(message: message);

  static ValidationRule<String> alphaDash({String? message}) =>
      AlphaDash(message: message);

  static ValidationRule<String> alphaNum({String? message}) =>
      AlphaNum(message: message);

  static ValidationRule<String> between(
          {required num min, required num max, String? message}) =>
      Between(min, max, message: message);

  static ValidationRule<String> boolean({String? message}) =>
      Boolean(message: message);

  static ValidationRule<String> date({String? message}) =>
      Date(message: message);

  static ValidationRule<String> digits(
          {required int digitLength, String? message}) =>
      Digits(digitLength, message: message);

  static ValidationRule<String> digitsBetween(
          {required num min, required num max, String? message}) =>
      DigitsBetween(min, max, message: message);

  static ValidationRule<String> email({String? message}) =>
      Email(message: message);

  static ValidationRule<T> inList<T>(List<T> validValues, {String? message}) =>
      InList(validValues, message: message);

  static ValidationRule<String> integer({String? message}) =>
      Integer(message: message);

  static ValidationRule<String> maxLength(int max, {String? message}) =>
      MaxLength(max, message: message);

  static ValidationRule<num> maxValue(int max, {String? message}) =>
      MaxValue(max, message: message);

  static ValidationRule<String> minLength(int min, {String? message}) =>
      MinLength(min, message: message);

  static ValidationRule<num> minValue(int min, {String? message}) =>
      MinValue(min, message: message);

  static ValidationRule<T> notInList<T>(List<T> invalidValues,
          {String? message}) =>
      NotInList(invalidValues, message: message);

  static ValidationRule<String> numeric({String? message}) =>
      Numeric(message: message);

  static ValidationRule<String> regex(RegExp regex, {String? message}) =>
      Regex(regex, message: message);

  static ValidationRule<T> same<T>(
          {required String otherField, String? message}) =>
      Same(otherField, message: message);

  static ValidationRule<String> size(int size, {String? message}) =>
      Size(size, message: message);

  static ValidationRule<String> url({String? message}) => Url(message: message);

  static ValidationRule<Iterable<T>?> minSelected<T>(int min,
          {String? message}) =>
      MinSelected<T>(min, message: message);

  static ValidationRule<Iterable<T>?> maxSelected<T>(int min,
          {String? message}) =>
      MaxSelected<T>(min, message: message);

  static ValidationRule<Iterable<T>?> rangeSelected<T>(
          {required int min, required int max, String? message}) =>
      RangeSelected<T>(min, max, message: message);

  static ValidationRule<DateTime> dateBefore(DateTime date,
          {String? message}) =>
      DateBefore(date, message: message);

  static ValidationRule<DateTime> dateAfter(DateTime date, {String? message}) =>
      DateBefore(date, message: message);

  static ValidationRule<DateTime?> dateBeforeFromString(String date,
          {String? format, String? message}) =>
      DateBefore.fromString(date, format: format, message: message);

  static ValidationRule<DateTime?> dateAfterFromString(String date,
          {String? format, String? message}) =>
      DateAfter.fromString(date, format: format, message: message);
}
