// ignore_for_file: unused_import

import 'package:beauty_habit_tracker/contact_and_futuretasks/contact_form.dart';
import 'package:emailjs/emailjs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('test Validator', () {
    test('null is not permited', () {
      expect(Validator.nonNullValidator(null), '*Required');
    });
    test('empty is not permited', () {
      expect(Validator.nonNullValidator(''), '*Required');
    });

    test('valid string', () {
      expect(Validator.nonNullValidator('test_name'), null);
    });

    test('test invalid email', () {
      expect(Validator.emailValidator('invalid_test_email'),
          'Please enter a valid Email');
    });

    test('valid email', () {
      expect(Validator.emailValidator('unobeautyhabittracker@gmail.com'), null);
    });
  });

  group('submit test', () {
    
    
  });
}
