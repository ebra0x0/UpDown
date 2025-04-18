import 'package:UpDown/core/errors/error_codes.dart';
import 'package:UpDown/core/errors/error_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class SupabaseFailure extends Failure {
  SupabaseFailure(super.errMessage);

  factory SupabaseFailure.fromAuth(AuthException e) {
    print(e.code);
    final SupabaseErrorCode code = SupabaseErrorExtension.fromCode(
        e.code ?? SupabaseErrorCode.unknown.code);

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
    final SupabaseErrorCode code = SupabaseErrorExtension.fromCode(
        e.code ?? SupabaseErrorCode.unknown.code);

    switch (code) {
      case SupabaseErrorCode.syntaxError:
        return SupabaseFailure("هناك خطأ في صيغة البيانات المدخلة.");
      case SupabaseErrorCode.permissionDenied ||
            SupabaseErrorCode.noPermissionForTable:
        return SupabaseFailure("ليس لديك صلاحيات كافية.");
      case SupabaseErrorCode.roleDoesNotExist:
        return SupabaseFailure("الدور غير موجود.");
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
    final SupabaseErrorCode code = SupabaseErrorExtension.fromCode(
        e.statusCode ?? SupabaseErrorCode.unknown.code);
    switch (code) {
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
        return SupabaseFailure("المورد موجود بالفعل.");
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

class CustomFailure extends Failure {
  CustomFailure(super.errMessage);

  CustomFailure.fromSocketException() : super("لا يوجد اتصال بالانترنت.");

  CustomFailure.fromTimeoutException() : super("انتهت مهلة الاتصال.");
}
