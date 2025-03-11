import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

enum SupabaseErrorCodes {
  // Authentication Errors
  invalidEmail,
  emailExists,
  emailNotConfirmed,
  wrongPassword,
  weakPassword,
  samePassword,
  phoneExists,
  phoneNotConfirmed,
  invalidCredentials,
  sessionExpired,
  userAlreadyExists,
  userNotFound,
  userBanned,
  userDisabled,

  // Database Errors (PostgreSQL)
  requestTimeout,
  uniqueViolation,
  foreignKeyViolation,
  notNullViolation,
  undefinedTable,
  undefinedColumn,
  syntaxError,
  undefinedFunction,

  // Storage Errors
  objectNotFound,
  bucketNotFound,
  storageUnauthorized,

  // Realtime Errors
  realtimeDisconnected,
  realtimeUnauthorized,
  realtimeLimitExceeded,

  // Unknown Error (default fallback)
  unknown;
}

// Extension to Map Error Codes
extension SupabaseErrorExtension on SupabaseErrorCodes {
  String get code {
    switch (this) {
      case SupabaseErrorCodes.invalidEmail:
        return "invalid-email";
      case SupabaseErrorCodes.emailExists:
        return "email_exists";
      case SupabaseErrorCodes.emailNotConfirmed:
        return "email_not_confirmed";
      case SupabaseErrorCodes.wrongPassword:
        return "wrong-password";
      case SupabaseErrorCodes.weakPassword:
        return "weak-password";
      case SupabaseErrorCodes.samePassword:
        return "same_password";
      case SupabaseErrorCodes.phoneExists:
        return "phone_exists";
      case SupabaseErrorCodes.phoneNotConfirmed:
        return "phone_not_confirmed";
      case SupabaseErrorCodes.invalidCredentials:
        return "invalid_credentials";
      case SupabaseErrorCodes.sessionExpired:
        return "session-expired";
      case SupabaseErrorCodes.userAlreadyExists:
        return "user_already_exists";
      case SupabaseErrorCodes.userNotFound:
        return "user-not-found";
      case SupabaseErrorCodes.userBanned:
        return "user-banned";
      case SupabaseErrorCodes.userDisabled:
        return "user-disabled";
      case SupabaseErrorCodes.uniqueViolation:
        return "23505";
      case SupabaseErrorCodes.foreignKeyViolation:
        return "23503";
      case SupabaseErrorCodes.notNullViolation:
        return "23502";
      case SupabaseErrorCodes.undefinedTable:
        return "42P01";
      case SupabaseErrorCodes.undefinedColumn:
        return "42703";
      case SupabaseErrorCodes.syntaxError:
        return "42601";
      case SupabaseErrorCodes.undefinedFunction:
        return "42883";
      case SupabaseErrorCodes.objectNotFound:
        return "object-not-found";
      case SupabaseErrorCodes.bucketNotFound:
        return "bucket-not-found";
      case SupabaseErrorCodes.storageUnauthorized:
        return "unauthorized";
      case SupabaseErrorCodes.realtimeDisconnected:
        return "disconnected";
      case SupabaseErrorCodes.realtimeUnauthorized:
        return "unauthorized";
      case SupabaseErrorCodes.realtimeLimitExceeded:
        return "limit-exceeded";
      case SupabaseErrorCodes.unknown:
        return "unknown";
      case SupabaseErrorCodes.requestTimeout:
        return "request-timeout";
    }
  }

  static SupabaseErrorCodes fromCode(String errorCode) {
    for (var error in SupabaseErrorCodes.values) {
      if (error.code == errorCode) return error;
    }
    return SupabaseErrorCodes.unknown;
  }
}

class SupabaseFailure extends Failure {
  SupabaseFailure(super.errMessage);

  factory SupabaseFailure.fromAuth(AuthException e) {
    final error = SupabaseErrorExtension.fromCode(
        e.code ?? SupabaseErrorCodes.unknown.code);

    switch (error) {
      case SupabaseErrorCodes.userBanned:
        return SupabaseFailure("حسابك محظور يرجى التواصل مع الادارة.");
      case SupabaseErrorCodes.userDisabled:
        return SupabaseFailure("حسابك معطل يرجى التواصل مع الادارة.");
      case SupabaseErrorCodes.userNotFound:
        return SupabaseFailure("حسابك غير موجود يرجى التواصل مع الادارة.");
      case SupabaseErrorCodes.userAlreadyExists:
        return SupabaseFailure("حسابك موجود بالفعل, يمكنك تسجيل الدخول.");
      case SupabaseErrorCodes.emailExists:
        return SupabaseFailure("البريد الالكتروني متسجل بالفعل.");
      case SupabaseErrorCodes.emailNotConfirmed:
        return SupabaseFailure("راجع رسايلك لتفعيل البريد الالكتروني.");
      case SupabaseErrorCodes.invalidEmail:
        return SupabaseFailure("يرجى استخدام بريد الكتروني صحيح.");
      case SupabaseErrorCodes.samePassword:
        return SupabaseFailure("جرب كلمة سر جديدة.");
      case SupabaseErrorCodes.weakPassword:
        return SupabaseFailure("يرجى استخدام كلمة سر قوية.");
      case SupabaseErrorCodes.wrongPassword:
        return SupabaseFailure("كلمة المرور غير صحيحة.");
      case SupabaseErrorCodes.phoneExists:
        return SupabaseFailure("رقم تليفونك متسجل بالفعل.");
      case SupabaseErrorCodes.phoneNotConfirmed:
        return SupabaseFailure("راجع رسايلك لتفعيل رقم التليفون.");
      case SupabaseErrorCodes.invalidCredentials:
        return SupabaseFailure("البريد الالكتروني او كلمة المرور غير صحيحة.");
      case SupabaseErrorCodes.sessionExpired:
        return SupabaseFailure("انتهت صلاحية الجلسة.");
      default:
        return SupabaseFailure("حدث خطأ غير متوقع وسيتم حله في أسرع وقت.");
    }
  }

  factory SupabaseFailure.fromDatabase(PostgrestException e) {
    final error = SupabaseErrorExtension.fromCode(
        e.code ?? SupabaseErrorCodes.unknown.code);

    switch (error) {
      case SupabaseErrorCodes.requestTimeout:
        return SupabaseFailure("الطلب أخد وقت كتير للأستجابة.");
      case SupabaseErrorCodes.uniqueViolation:
        return SupabaseFailure("لا يمكن ادخال بيانات مكررة.");
      case SupabaseErrorCodes.undefinedColumn:
        return SupabaseFailure("العمود غير موجود.");
      case SupabaseErrorCodes.foreignKeyViolation:
        return SupabaseFailure(
            "لا يمكن الحذف أو التحديث بسبب وجود بيانات مرتبطة");
      case SupabaseErrorCodes.notNullViolation:
        return SupabaseFailure("لا يمكن ادخال بيانات فارغة.");
      case SupabaseErrorCodes.undefinedFunction:
        return SupabaseFailure("الدالة غير موجودة.");
      case SupabaseErrorCodes.syntaxError:
        return SupabaseFailure("خطاء في صيغة البيانات.");
      case SupabaseErrorCodes.undefinedTable:
        return SupabaseFailure("الجدول غير موجود.");
      default:
        return SupabaseFailure("حدث خطأ غير متوقع وسيتم حله في أسرع وقت.");
    }
  }

  factory SupabaseFailure.fromStorage(StorageException e) {
    switch (e.statusCode) {
      case "404":
        return SupabaseFailure("الملف أو الحاوية غير موجود");
      case "401":
      case "403":
        return SupabaseFailure("غير مصرح لك بالوصول");
      case "413":
        return SupabaseFailure("حجم الملف يتجاوز الحد المسموح");
      case "400":
        return SupabaseFailure("مسار أو نوع ملف غير صالح");
      case "507":
        return SupabaseFailure("تم تجاوز سعة التخزين");
      case "429":
        return SupabaseFailure("عدد الطلبات كبير جدًا");
      case "500":
        return SupabaseFailure("حدث خطاء في الخادم");
      default:
        return SupabaseFailure("حدث خطاء غير متوقع وسيتم حله في أسرع وقت.");
    }
  }
}

class CustomException extends Failure {
  CustomException(super.errMessage);

  CustomException.fromSocketException() : super("لا يوجد اتصال بالانترنت.");

  CustomException.fromTimeoutException() : super("انتهت مهلة الاتصال.");
}
