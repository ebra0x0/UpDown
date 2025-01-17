import 'package:supabase_flutter/supabase_flutter.dart';

void authExceptionsHandler(AuthException error) {
  switch (error.code) {
    case "user_not_found":
      throw AuthException("البريد الالكتروني غير موجود.");
    case "user_banned":
      throw AuthException("حسابك محظور يرجى التواصل مع الادارة.");
    case "email_exists":
      throw AuthException("البريد الالكتروني موجود بالفعل.");
    case "email_address_invalid":
      throw AuthException("البريد الالكتروني غير صحيح.");
    case "email_not_confirmed":
      throw AuthException(
          "حسابك لم يتم تفعيله برجاء مراجعة بريدك لتفعيل الحساب");
    case "invalid_password":
      throw AuthException("كلمة المرور غير صحيحة.");

    default:
      throw AuthException("حدث خطأ ما.");
  }
}
