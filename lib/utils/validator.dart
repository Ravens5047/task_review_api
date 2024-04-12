import 'form_validator.dart';

class Validator {
  static final requiredValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required'),
  ]);

  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required'),
    MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),
  ]);

  static final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required'),
    EmailValidator(errorText: 'Enter a valid email address'),
  ]);

  static MultiValidator confirmPasswordValidator(String? password) =>
      MultiValidator([
        RequiredValidator(errorText: 'This field is required'),
        MatchValidator(password, errorText: 'Confirm password is not match'),
      ]);
}
