abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

enum SupabaseError {
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
  requestTimeout,

  // Database Errors (PostgreSQL)
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
extension SupabaseErrorExtension on SupabaseError {
  String get code {
    switch (this) {
      case SupabaseError.invalidEmail:
        return "auth/invalid-email";
      case SupabaseError.emailExists:
        return "auth/email_exists";
      case SupabaseError.emailNotConfirmed:
        return "auth/email_not_confirmed";
      case SupabaseError.wrongPassword:
        return "auth/wrong-password";
      case SupabaseError.weakPassword:
        return "auth/weak-password";
      case SupabaseError.samePassword:
        return "auth/same_password";
      case SupabaseError.phoneExists:
        return "auth/phone_exists";
      case SupabaseError.phoneNotConfirmed:
        return "auth/phone_not_confirmed";
      case SupabaseError.invalidCredentials:
        return "auth/invalid_credentials";
      case SupabaseError.sessionExpired:
        return "auth/session-expired";
      case SupabaseError.userAlreadyExists:
        return "auth/user_already_exists";
      case SupabaseError.userNotFound:
        return "auth/user-not-found";
      case SupabaseError.userBanned:
        return "auth/user-banned";
      case SupabaseError.userDisabled:
        return "auth/user-disabled";
      case SupabaseError.uniqueViolation:
        return "23505";
      case SupabaseError.foreignKeyViolation:
        return "23503";
      case SupabaseError.notNullViolation:
        return "23502";
      case SupabaseError.undefinedTable:
        return "42P01";
      case SupabaseError.undefinedColumn:
        return "42703";
      case SupabaseError.syntaxError:
        return "42601";
      case SupabaseError.undefinedFunction:
        return "42883";
      case SupabaseError.objectNotFound:
        return "storage/object-not-found";
      case SupabaseError.bucketNotFound:
        return "storage/bucket-not-found";
      case SupabaseError.storageUnauthorized:
        return "storage/unauthorized";
      case SupabaseError.realtimeDisconnected:
        return "realtime/disconnected";
      case SupabaseError.realtimeUnauthorized:
        return "realtime/unauthorized";
      case SupabaseError.realtimeLimitExceeded:
        return "realtime/limit-exceeded";
      case SupabaseError.unknown:
        return "unknown";
      case SupabaseError.requestTimeout:
        return "request-timeout";
    }
  }

  static SupabaseError fromCode(String errorCode) {
    for (var error in SupabaseError.values) {
      if (error.code == errorCode) return error;
    }
    return SupabaseError.unknown;
  }
}

class SupabaseFailure extends Failure {
  SupabaseFailure(super.errMessage);

  String handleSupabaseError(String errorCode) {
    final error = SupabaseErrorExtension.fromCode(errorCode);

    switch (error) {
      case SupabaseError.userBanned:
        return "حسابك محظور يرجى التواصل مع الادارة.";
      case SupabaseError.samePassword:
        return "جرب كلمة سر جديدة.";
      case SupabaseError.phoneExists:
        return "رقم تليفونك متسجل بالفعل.";
      case SupabaseError.phoneNotConfirmed:
        return "راجع رسايلك لتفعيل رقم التليفون.";
      case SupabaseError.invalidCredentials:
        return "البريد الالكتروني او كلمة المرور غير صحيحة.";
      case SupabaseError.sessionExpired:
        return "انتهت صلاحية الجلسة.";
      case SupabaseError.userDisabled:
        return "حسابك معطل يرجى التواصل مع الادارة.";
      case SupabaseError.requestTimeout:
        return "الطلب أخد وقت كتير للأستجابة.";
      case SupabaseError.userNotFound:
        return "يبدو انك لا تملك حساب بعد, يمكنك انشاء حساب جديد.";
      case SupabaseError.invalidEmail:
        return "الايميل غير صحيح.";
      case SupabaseError.emailExists:
        return "الايميل المدخل موجود بالفعل.";
      case SupabaseError.emailNotConfirmed:
        return "حسابك لم يتم تفعيله برجاء مراجعة بريدك لتفعيل الحساب.";
      case SupabaseError.userAlreadyExists:
        return "يبدو أنك تملك حساب بالفعل, يمكنك تسجيل الدخول.";
      case SupabaseError.wrongPassword:
        return "كلمة المرور غير صحيحة.";
      case SupabaseError.weakPassword:
        return "كلمة المرور ضعيفة.";
      default:
        print("handleSupabaseError error => $error");
        return "هناك مشكلة وجاري العمل على حلها.";
    }
  }
}
