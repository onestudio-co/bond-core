import 'dart:ui';

import 'package:intl/intl.dart';

import 'validator_messages_all.dart';

class ValidatorLocalizations {
  ValidatorLocalizations(this.localeName);

  static Future<ValidatorLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null || locale.countryCode!.isEmpty
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return ValidatorLocalizations(localeName);
    });
  }

  final String localeName;

  String requiredValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName is required.',
      name: 'requiredValidationMessage',
      desc: 'Validation message for a required field',
      args: [fieldName],
      locale: localeName,
    );
  }

  String emailValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be a valid email address.',
      name: 'emailValidationMessage',
      desc: 'Validation message for an email field',
      args: [fieldName],
      locale: localeName,
    );
  }

  String minValueValidationMessage(String fieldName, int value) {
    return Intl.message(
      '$fieldName must have a minimum value of $value.',
      name: 'minValueValidationMessage',
      desc: 'Validation message for a field with minimum value',
      args: [fieldName, value],
      locale: localeName,
    );
  }

  String maxValueValidationMessage(String fieldName, int value) {
    return Intl.message(
      '$fieldName must have a maximum value of $value.',
      name: 'maxValueValidationMessage',
      desc: 'Validation message for a field with maximum value',
      args: [fieldName, value],
      locale: localeName,
    );
  }

  String inValuesValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be in the given list.',
      name: 'inValuesValidationMessage',
      desc: 'Validation message for a field that must be in a list',
      args: [fieldName],
      locale: localeName,
    );
  }

  String notInValuesValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName should not be in the given list.',
      name: 'notInValuesValidationMessage',
      desc: 'Validation message for a field that should not be in a list',
      args: [fieldName],
      locale: localeName,
    );
  }

  String integerValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be an integer.',
      name: 'integerValidationMessage',
      desc: 'Validation message for a field that should be an integer',
      args: [fieldName],
      locale: localeName,
    );
  }

  String numericValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be numeric.',
      name: 'numericValidationMessage',
      desc: 'Validation message for a field that should be numeric',
      args: [fieldName],
      locale: localeName,
    );
  }

  String digitsValidationMessage(String fieldName, int value) {
    return Intl.message(
      '$fieldName must be numeric and have a length of exactly $value.',
      name: 'digitsValidationMessage',
      desc:
          'Validation message for a field that should be numeric and have a specific length',
      args: [fieldName, value],
      locale: localeName,
    );
  }

  String digitsBetweenValidationMessage(String fieldName, int min, int max) {
    return Intl.message(
      '$fieldName must have a length between $min and $max.',
      name: 'digitsBetweenValidationMessage',
      desc:
          'Validation message for a field that should have a length between two values',
      args: [fieldName, min, max],
      locale: localeName,
    );
  }

  String sizeValidationMessage(String fieldName, int value) {
    return Intl.message(
      '$fieldName must have a size of $value.',
      name: 'sizeValidationMessage',
      desc: 'Validation message for a field that should have a specific size',
      args: [fieldName, value],
      locale: localeName,
    );
  }

  String betweenValidationMessage(String fieldName, int min, int max) {
    return Intl.message(
      '$fieldName must have a size between $min and $max.',
      name: 'betweenValidationMessage',
      desc:
          'Validation message for a field that should have a size between two values',
      args: [fieldName, min, max],
      locale: localeName,
    );
  }

  String booleanValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be boolean (true, false, 1, 0, \'1\', \'0\').',
      name: 'booleanValidationMessage',
      desc: 'Validation message for a field that should be boolean',
      args: [fieldName],
      locale: localeName,
    );
  }

  String confirmedValidationMessage(String fieldName) {
    return Intl.message(
      'Confirmation of $fieldName does not match.',
      name: 'confirmedValidationMessage',
      desc: 'Validation message for a field that needs confirmation',
      args: [fieldName],
      locale: localeName,
    );
  }

  String dateValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be a valid date.',
      name: 'dateValidationMessage',
      desc: 'Validation message for a field that should be a date',
      args: [fieldName],
      locale: localeName,
    );
  }

  String dateFormatValidationMessage(String fieldName, String format) {
    return Intl.message(
      '$fieldName must be in the format $format.',
      name: 'dateFormatValidationMessage',
      desc:
          'Validation message for a field that should comply with a specific format',
      args: [fieldName, format],
      locale: localeName,
    );
  }

  String differentValidationMessage(String fieldName, String field) {
    return Intl.message(
      '$fieldName must have a different value from $field.',
      name: 'differentValidationMessage',
      desc:
          'Validation message for a field that should be different from another field',
      args: [fieldName, field],
      locale: localeName,
    );
  }

  String sameValidationMessage(String fieldName, String field) {
    return Intl.message(
      '$fieldName must have the same value as $field.',
      name: 'sameValidationMessage',
      desc:
          'Validation message for a field that should have the same value as another field',
      args: [fieldName, field],
      locale: localeName,
    );
  }

  String alphaValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must contain only alphabetic characters.',
      name: 'alphaValidationMessage',
      desc:
          'Validation message for a field that should contain only alphabetic characters',
      args: [fieldName],
      locale: localeName,
    );
  }

  String alphaDashValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName may only contain alphanumeric characters, dashes, and underscores.',
      name: 'alphaDashValidationMessage',
      desc:
          'Validation message for a field that may only contain alphanumeric characters, dashes, and underscores',
      args: [fieldName],
      locale: localeName,
    );
  }

  String alphaNumValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must only contain alphanumeric characters.',
      name: 'alphaNumValidationMessage',
      desc:
          'Validation message for a field that must only contain alphanumeric characters',
      args: [fieldName],
      locale: localeName,
    );
  }

  String urlValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be a valid URL.',
      name: 'urlValidationMessage',
      desc: 'Validation message for a field that must be a valid URL',
      args: [fieldName],
      locale: localeName,
    );
  }

  String regexValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must match the specified pattern.',
      name: 'regexValidationMessage',
      desc: 'Validation message for a field that must match a regex pattern',
      args: [fieldName],
      locale: localeName,
    );
  }
}
