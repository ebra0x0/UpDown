import 'package:UpDown/core/utils/normalization.dart';

class Validator {
  Validator({this.password});

  String? password;

  String? emailValidator(String? email) {
    final regex = Normalization.kEmailRegex;
    if (email == null || !regex.hasMatch(email)) {
      return ("إيميل غير صحيح.");
    } else {
      return null;
    }
  }

  String? regestrationPasswordValidator(String? password) {
    final RegExp regex = Normalization.kPasswordRegex;
    if (password == null || !regex.hasMatch(password)) {
      return ("كلمة مرور ضعيفة.");
    } else {
      return null;
    }
  }

  String? loginPasswordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return ("ادخل كلمة المرور.");
    } else {
      return null;
    }
  }

  String? confirmPasswordValidator(String? rePassword) {
    if (rePassword != password) {
      return ("كلمة المرور غير متطابقة.");
    } else {
      return null;
    }
  }

  String? nameValidator(String? name) {
    if (name == null || name.length < 3) {
      return ("الأسم قصير جداً.");
    } else {
      return null;
    }
  }
}
