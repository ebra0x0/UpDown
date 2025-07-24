import 'package:UpDown/core/utils/constants/regex.dart';

abstract class Validator {
  static String? emailValidator(String? email) {
    final regex = Regex.kEmailRegex;
    if (email == null || email.isEmpty || !regex.hasMatch(email)) {
      return ("إيميل غير صالح.");
    }
    return null;
  }

  static String? regestrationPasswordValidator(String? password) {
    final RegExp regex = Regex.kPasswordRegex;
    if (password == null || password.isEmpty || !regex.hasMatch(password)) {
      return ("كلمة مرور ضعيفة.");
    }
    return null;
  }

  static String? loginPasswordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return ("ادخل كلمة المرور.");
    }
    return null;
  }

  static String? confirmPasswordValidator(
      {required String? password, String? rePassword}) {
    if (password == null || password.isEmpty) {
      return ("ادخل كلمة المرور.");
    }
    if (rePassword != password) {
      return ("كلمة المرور غير متطابقة.");
    }
    return null;
  }

  static String? nameValidator(String? name) {
    if (name == null || name.length < 3) {
      return ("الاسم يجب الا يقل عن 3 حروف.");
    }
    return null;
  }

  static String? phoneValidator(String? phone) {
    final regex = Regex.kPhoneRegex;
    if (phone == null || phone.isEmpty || !regex.hasMatch(phone)) {
      return ("رقم الهاتف غير صالح.");
    }
    return null;
  }

  static String? addressValidator(String? address) {
    if (address == null || address.isEmpty || address.length < 8) {
      return ("العنوان غير صالح.");
    }
    return null;
  }
}
