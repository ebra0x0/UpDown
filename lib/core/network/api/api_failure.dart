import 'package:supabase_flutter/supabase_flutter.dart';

enum SupabaseErrorCode {
  // Sign In Errors
  invalidCredentials("invalid_credentials"),
  emailNotConfirmed("email_not_confirmed"),
  phoneNotConfirmed("phone_not_confirmed"),
  otpExpired("otp_expired"),
  mfaChallengeExpired("mfa_challenge_expired"),
  reauthenticationNeeded("reauthentication_needed"),
  reauthenticationNotValid("reauthentication_not_valid"),
  userBanned("user_banned"),
  userNotFound("user_not_found"),
  providerEmailNeedsVerification("provider_email_needs_verification"),

  // Sign Up Errors
  emailExists("email_exists"),
  phoneExists("phone_exists"),
  weakPassword("weak_password"),
  signupDisabled("signup_disabled"),
  emailAddressInvalid("email_address_invalid"),
  emailAddressNotAuthorized("email_address_not_authorized"),
  userAlreadyExists("user_already_exists"),

  // Update Password Errors
  samePassword("same_password"),

  // MFA Errors
  mfaVerificationFailed("mfa_verification_failed"),
  mfaFactorNotFound("mfa_factor_not_found"),
  mfaTotpEnrollNotEnabled("mfa_totp_enroll_not_enabled"),
  mfaIpAddressMismatch("mfa_ip_address_mismatch"),
  mfaPhoneEnrollNotEnabled("mfa_phone_enroll_not_enabled"),
  mfaVerifiedFactorExists("mfa_verified_factor_exists"),

  // Session Errors
  sessionExpired("session_expired"),
  sessionNotFound("session_not_found"),
  refreshTokenNotFound("refresh_token_not_found"),
  refreshTokenAlreadyUsed("refresh_token_already_used"),
  noAuthorization("no_authorization"),

  // Rate Limiting Errors
  overEmailSendRateLimit("over_email_send_rate_limit"),
  overSmsSendRateLimit("over_sms_send_rate_limit"),
  overRequestRateLimit("over_request_rate_limit"),

  // OAuth/SAML/SSO Errors
  oauthProviderNotSupported("oauth_provider_not_supported"),
  providerDisabled("provider_disabled"),
  samlIdpNotFound("saml_idp_not_found"),
  samlAssertionNoEmail("saml_assertion_no_email"),
  samlRelayStateExpired("saml_relay_state_expired"),

  // Postgres Errors
  notFound("404"),
  syntaxError("syntax_error"),
  permissionDenied("permission_denied"),
  roleDoesNotExist("role_does_not_exist"),
  relationDoesNotExist("relation_does_not_exist"),
  connectionFailed("connection_failed"),
  invalidInputSyntax("invalid_input_syntax"),
  columnDoesNotExist("column_does_not_exist"),
  databaseDoesNotExist("database_does_not_exist"),
  noPermissionForTable("no_permission_for_table"),
  diskFull("disk_full"),

  // Storage Errors
  unauthorized("403"),
  noSuchBucket("404"),
  noSuchKey("404"),
  noSuchUpload("404"),
  invalidJwt("401"),
  invalidRequest("400"),
  tenantNotFound("404"),
  entityTooLarge("413"),
  internalError("500"),
  resourceAlreadyExists("409"),
  invalidBucketName("400"),
  invalidKey("400"),
  invalidRange("416"),
  invalidMimeType("400"),
  invalidUploadId("400"),
  keyAlreadyExists("409"),
  bucketAlreadyExists("409"),
  databaseTimeout("504"),
  invalidSignature("403"),
  signatureDoesNotMatch("403"),
  accessDenied("403"),
  resourceLocked("423"),
  databaseError("500"),
  missingContentLength("411"),
  missingParameter("400"),
  invalidUploadSignature("403"),
  lockTimeout("423"),
  s3Error("-"),
  s3InvalidAccessKeyId("403"),
  s3MaximumCredentialsLimit("400"),
  invalidChecksum("400"),
  missingPart("400"),
  slowDown("503"),

  // Other Errors
  badJson("bad_json"),
  badJwt("bad_jwt"),
  requestTimeout("request_timeout"),
  unexpectedFailure("unexpected_failure"),
  conflict("conflict"),
  flowStateExpired("flow_state_expired"),

  // Unknown Error (default fallback)
  unknown("unknown");

  final String code;
  const SupabaseErrorCode(this.code);

  static final Map<String, SupabaseErrorCode> _codeMap = {
    for (var error in SupabaseErrorCode.values) error.code: error
  };

  static SupabaseErrorCode fromCode(String errorCode) {
    return _codeMap[errorCode] ?? SupabaseErrorCode.unknown;
  }
}

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class SupabaseFailure extends Failure {
  SupabaseFailure(super.errMessage);

  factory SupabaseFailure.fromAuth(AuthException e) {
    final SupabaseErrorCode code =
        SupabaseErrorCode.fromCode(e.code ?? "unknown");

    switch (code) {
      case SupabaseErrorCode.overEmailSendRateLimit:
        return SupabaseFailure(
            "لقد ارسلت رموز كثيرة. يرجى المحاولة في وقت لاحق.");
      case SupabaseErrorCode.userBanned:
        return SupabaseFailure("حسابك محظور. يرجى التواصل مع الإدارة.");
      case SupabaseErrorCode.userNotFound:
        return SupabaseFailure(
            "حسابك غير موجود أو تم حذفه. يرجى التواصل مع الإدارة.");
      case SupabaseErrorCode.userAlreadyExists:
        return SupabaseFailure(
            "البريد الإلكتروني أو رقم الهاتف مستخدم بالفعل. يمكنك تسجيل الدخول.");
      case SupabaseErrorCode.emailExists:
        return SupabaseFailure(
            "البريد الإلكتروني متسجل بالفعل. حاول استخدام بريد آخر.");
      case SupabaseErrorCode.emailNotConfirmed:
        return SupabaseFailure("راجع رسائل البريد الإلكتروني لتفعيل الحساب.");
      case SupabaseErrorCode.emailAddressInvalid:
        return SupabaseFailure("يرجى استخدام بريد إلكتروني صالح.");
      case SupabaseErrorCode.samePassword:
        return SupabaseFailure("يرجى استخدام كلمة مرور جديدة.");
      case SupabaseErrorCode.weakPassword:
        return SupabaseFailure(
            "كلمة المرور ضعيفة. يرجى اختيار كلمة مرور قوية.");
      case SupabaseErrorCode.phoneExists:
        return SupabaseFailure("رقم الهاتف مسجل بالفعل.");
      case SupabaseErrorCode.phoneNotConfirmed:
        return SupabaseFailure("راجع رسائل الهاتف لتفعيل الرقم.");
      case SupabaseErrorCode.invalidCredentials:
        return SupabaseFailure("البريد الإلكتروني أو كلمة المرور غير صحيحة.");
      case SupabaseErrorCode.sessionExpired:
        return SupabaseFailure(
            "انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.");
      case SupabaseErrorCode.signupDisabled:
        return SupabaseFailure("التسجيل غير مفعل حاليًا.");
      case SupabaseErrorCode.refreshTokenNotFound:
        return SupabaseFailure("لم يتم العثور على رمز التحديث.");
      case SupabaseErrorCode.otpExpired:
        return SupabaseFailure("انتهت صلاحية رمز OTP. حاول من جديد.");
      case SupabaseErrorCode.mfaVerificationFailed:
        return SupabaseFailure("فشل التحقق من MFA.");
      default:
        return SupabaseFailure(
            "حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى لاحقًا.");
    }
  }

  factory SupabaseFailure.fromDatabase(PostgrestException e) {
    final SupabaseErrorCode code =
        SupabaseErrorCode.fromCode(e.code ?? "unknown");

    switch (code) {
      case SupabaseErrorCode.notFound:
        return SupabaseFailure("هذا الطلب غير موجود.");
      case SupabaseErrorCode.syntaxError:
        return SupabaseFailure("هناك خطأ في صيغة البيانات المدخلة.");
      case SupabaseErrorCode.permissionDenied:
      case SupabaseErrorCode.noPermissionForTable:
        return SupabaseFailure("ليس لديك صلاحيات كافية.");
      case SupabaseErrorCode.roleDoesNotExist:
        return SupabaseFailure("هذه الصلاحية غير موجودة.");
      case SupabaseErrorCode.relationDoesNotExist:
        return SupabaseFailure("العلاقة غير موجودة.");
      case SupabaseErrorCode.connectionFailed:
        return SupabaseFailure("فشل الاتصال بالخادم.");
      case SupabaseErrorCode.invalidInputSyntax:
        return SupabaseFailure("صيغة البيانات المدخلة غير صحيحة.");
      case SupabaseErrorCode.columnDoesNotExist:
        return SupabaseFailure("هذا الطلب غير موجود.");
      case SupabaseErrorCode.databaseDoesNotExist || SupabaseErrorCode.diskFull:
        return SupabaseFailure("هناك مشكلة في السيرفر، يرجى المحاولة لاحقًا.");
      default:
        return SupabaseFailure("حدث خطأ غير متوقع، يرجى المحاولة لاحقاً.");
    }
  }

  factory SupabaseFailure.fromStorage(StorageException e) {
    final SupabaseErrorCode code =
        SupabaseErrorCode.fromCode(e.statusCode ?? "unknown");

    switch (code) {
      case SupabaseErrorCode.unauthorized:
        return SupabaseFailure("غير مصرح لك.");
      case SupabaseErrorCode.noSuchBucket:
        return SupabaseFailure("الحاوية غير موجودة.");
      case SupabaseErrorCode.noSuchKey:
        return SupabaseFailure("المفتاح غير موجود.");
      case SupabaseErrorCode.noSuchUpload:
        return SupabaseFailure("عملية الرفع غير موجودة.");
      case SupabaseErrorCode.invalidJwt:
        return SupabaseFailure("رمز التوثيق (JWT) غير صالح.");
      case SupabaseErrorCode.invalidRequest:
        return SupabaseFailure("الطلب غير صحيح.");
      case SupabaseErrorCode.tenantNotFound:
        return SupabaseFailure("العميل غير موجود.");
      case SupabaseErrorCode.entityTooLarge:
        return SupabaseFailure("حجم الملف كبير جدًا.");
      case SupabaseErrorCode.internalError:
        return SupabaseFailure("حدث خطأ داخلي في النظام.");
      case SupabaseErrorCode.resourceAlreadyExists:
        return SupabaseFailure("الملف موجود بالفعل.");
      case SupabaseErrorCode.invalidBucketName:
        return SupabaseFailure("اسم الحاوية غير صالح.");
      case SupabaseErrorCode.invalidKey:
        return SupabaseFailure("المفتاح غير صالح.");
      case SupabaseErrorCode.invalidRange:
        return SupabaseFailure("النطاق المحدد غير صالح.");
      case SupabaseErrorCode.invalidMimeType:
        return SupabaseFailure("نوع الملف غير صالح.");
      case SupabaseErrorCode.invalidUploadId:
        return SupabaseFailure("رقم التعريف الخاص بالرفع غير صالح.");
      case SupabaseErrorCode.keyAlreadyExists:
        return SupabaseFailure("المفتاح موجود بالفعل.");
      case SupabaseErrorCode.bucketAlreadyExists:
        return SupabaseFailure("الحاوية موجودة بالفعل.");
      case SupabaseErrorCode.databaseTimeout:
        return SupabaseFailure("انتهت مدة الاتصال بقاعدة البيانات.");
      case SupabaseErrorCode.invalidSignature:
        return SupabaseFailure("التوقيع غير صالح.");
      case SupabaseErrorCode.signatureDoesNotMatch:
        return SupabaseFailure("التوقيع لا يتطابق مع التوقيع المحسوب.");
      case SupabaseErrorCode.accessDenied:
        return SupabaseFailure("تم رفض الوصول.");
      case SupabaseErrorCode.resourceLocked:
        return SupabaseFailure("المورد محجوز ولا يمكن التعديل عليه الآن.");
      case SupabaseErrorCode.databaseError:
        return SupabaseFailure("حدث خطأ أثناء الوصول إلى قاعدة البيانات.");
      case SupabaseErrorCode.missingContentLength:
        return SupabaseFailure("الحجم المطلوب مفقود.");
      case SupabaseErrorCode.missingParameter:
        return SupabaseFailure("معامل مفقود في الطلب.");
      case SupabaseErrorCode.invalidUploadSignature:
        return SupabaseFailure("التوقيع الخاص بالرفع غير صالح.");
      case SupabaseErrorCode.lockTimeout:
        return SupabaseFailure("تأخير في الحصول على القفل.");
      case SupabaseErrorCode.s3Error:
        return SupabaseFailure("حدث خطأ متصل بـ S3.");
      case SupabaseErrorCode.s3InvalidAccessKeyId:
        return SupabaseFailure("معرف الوصول إلى S3 غير صالح.");
      case SupabaseErrorCode.s3MaximumCredentialsLimit:
        return SupabaseFailure(
            "تم الوصول إلى الحد الأقصى لعدد بيانات الاعتماد.");
      case SupabaseErrorCode.invalidChecksum:
        return SupabaseFailure("التحقق من صحة البيانات غير صحيح.");
      case SupabaseErrorCode.missingPart:
        return SupabaseFailure("جزء مفقود من البيانات.");
      case SupabaseErrorCode.slowDown:
        return SupabaseFailure("يرجى المحاولة لاحقًا.");
      default:
        return SupabaseFailure("حدث خطأ غير متوقع.");
    }
  }
}

class NetworkFailure extends Failure {
  NetworkFailure(super.errMessage);

  NetworkFailure.fromSocketException() : super("لا يوجد اتصال بالانترنت");

  NetworkFailure.fromTimeoutException()
      : super("العملية استغرقت وقتًا طويلاً. يرجى المحاولة لاحقًا");
}

class CustomFailure extends Failure {
  CustomFailure(super.errMessage);
}
