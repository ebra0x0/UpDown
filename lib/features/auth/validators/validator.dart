class Validator {
  Validator({this.password});

  String? password;

  String? emailValidator(String? email) {
    final regex = RegExp(
        r'^(?=[^@]*[a-zA-Z])([a-zA-Z0-9._%+-]+)@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email == null || !regex.hasMatch(email)) {
      return ("إيميل غير صحيح.");
    } else {
      return null;
    }
  }

  String? passwordValidator(String? password) {
    final RegExp regex = RegExp(r'^(?=.*?)(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if (password == null || !regex.hasMatch(password)) {
      return ("كلمة مرور ضعيفة");
    } else {
      return null;
    }
  }

  String? rePasswordValidator(String? rePassword) {
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

  String? floorValidator(String? floor) {
    final regex = RegExp(r'^\d+$');
    if (floor == null || !regex.hasMatch(floor)) {
      return ("رقم الطابق غير صحيح.");
    } else {
      return null;
    }
  }
}
