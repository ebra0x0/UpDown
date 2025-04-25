import 'package:UpDown/core/errors/error_codes.dart';

extension SupabaseErrorExtension on SupabaseErrorCode {
  String get code {
    switch (this) {
      // Auth Errors
      case SupabaseErrorCode.invalidCredentials:
        return "invalid_credentials";
      case SupabaseErrorCode.emailNotConfirmed:
        return "email_not_confirmed";
      case SupabaseErrorCode.otpExpired:
        return "otp_expired";
      case SupabaseErrorCode.mfaVerificationFailed:
        return "mfa_verification_failed";
      case SupabaseErrorCode.mfaChallengeExpired:
        return "mfa_challenge_expired";
      case SupabaseErrorCode.reauthenticationNeeded:
        return "reauthentication_needed";
      case SupabaseErrorCode.reauthenticationNotValid:
        return "reauthentication_not_valid";
      case SupabaseErrorCode.userBanned:
        return "user_banned";
      case SupabaseErrorCode.userNotFound:
        return "user_not_found";
      case SupabaseErrorCode.providerEmailNeedsVerification:
        return "provider_email_needs_verification";
      case SupabaseErrorCode.emailExists:
        return "email_exists";
      case SupabaseErrorCode.phoneExists:
        return "phone_exists";
      case SupabaseErrorCode.weakPassword:
        return "weak_password";
      case SupabaseErrorCode.samePassword:
        return "same_password";
      case SupabaseErrorCode.signupDisabled:
        return "signup_disabled";
      case SupabaseErrorCode.emailAddressInvalid:
        return "email_address_invalid";
      case SupabaseErrorCode.emailAddressNotAuthorized:
        return "email_address_not_authorized";
      case SupabaseErrorCode.userAlreadyExists:
        return "user_already_exists";
      case SupabaseErrorCode.mfaFactorNotFound:
        return "mfa_factor_not_found";
      case SupabaseErrorCode.mfaTotpEnrollNotEnabled:
        return "mfa_totp_enroll_not_enabled";
      case SupabaseErrorCode.mfaIpAddressMismatch:
        return "mfa_ip_address_mismatch";
      case SupabaseErrorCode.mfaPhoneEnrollNotEnabled:
        return "mfa_phone_enroll_not_enabled";
      case SupabaseErrorCode.mfaVerifiedFactorExists:
        return "mfa_verified_factor_exists";
      case SupabaseErrorCode.sessionExpired:
        return "session_expired";
      case SupabaseErrorCode.sessionNotFound:
        return "session_not_found";
      case SupabaseErrorCode.refreshTokenNotFound:
        return "refresh_token_not_found";
      case SupabaseErrorCode.refreshTokenAlreadyUsed:
        return "refresh_token_already_used";
      case SupabaseErrorCode.noAuthorization:
        return "no_authorization";
      case SupabaseErrorCode.overEmailSendRateLimit:
        return "over_email_send_rate_limit";
      case SupabaseErrorCode.overSmsSendRateLimit:
        return "over_sms_send_rate_limit";
      case SupabaseErrorCode.overRequestRateLimit:
        return "over_request_rate_limit";
      case SupabaseErrorCode.oauthProviderNotSupported:
        return "oauth_provider_not_supported";
      case SupabaseErrorCode.providerDisabled:
        return "provider_disabled";
      case SupabaseErrorCode.samlIdpNotFound:
        return "saml_idp_not_found";
      case SupabaseErrorCode.samlAssertionNoEmail:
        return "saml_assertion_no_email";
      case SupabaseErrorCode.samlRelayStateExpired:
        return "saml_relay_state_expired";
      case SupabaseErrorCode.badJson:
        return "bad_json";
      case SupabaseErrorCode.badJwt:
        return "bad_jwt";
      case SupabaseErrorCode.requestTimeout:
        return "request_timeout";
      case SupabaseErrorCode.unexpectedFailure:
        return "unexpected_failure";
      case SupabaseErrorCode.conflict:
        return "conflict";
      case SupabaseErrorCode.flowStateExpired:
        return "flow_state_expired";

      // PostgreSQL Errors
      case SupabaseErrorCode.notFound:
        return "404";
      case SupabaseErrorCode.syntaxError:
        return "syntax_error";
      case SupabaseErrorCode.permissionDenied:
        return "permission_denied";
      case SupabaseErrorCode.roleDoesNotExist:
        return "role_does_not_exist";
      case SupabaseErrorCode.relationDoesNotExist:
        return "relation_does_not_exist";
      case SupabaseErrorCode.connectionFailed:
        return "connection_failed";
      case SupabaseErrorCode.invalidInputSyntax:
        return "invalid_input_syntax";
      case SupabaseErrorCode.columnDoesNotExist:
        return "column_does_not_exist";
      case SupabaseErrorCode.databaseDoesNotExist:
        return "database_does_not_exist";
      case SupabaseErrorCode.noPermissionForTable:
        return "no_permission_for_table";
      case SupabaseErrorCode.diskFull:
        return "disk_full";

      // Storage Errors
      case SupabaseErrorCode.unauthorized:
        return "403";
      case SupabaseErrorCode.noSuchBucket:
        return "404";
      case SupabaseErrorCode.noSuchKey:
        return "404";
      case SupabaseErrorCode.noSuchUpload:
        return "404";
      case SupabaseErrorCode.invalidJwt:
        return "401";
      case SupabaseErrorCode.invalidRequest:
        return "400";
      case SupabaseErrorCode.tenantNotFound:
        return "404";
      case SupabaseErrorCode.entityTooLarge:
        return "413";
      case SupabaseErrorCode.internalError:
        return "500";
      case SupabaseErrorCode.resourceAlreadyExists:
        return "409";
      case SupabaseErrorCode.invalidBucketName:
        return "400";
      case SupabaseErrorCode.invalidKey:
        return "400";
      case SupabaseErrorCode.invalidRange:
        return "416";
      case SupabaseErrorCode.invalidMimeType:
        return "400";
      case SupabaseErrorCode.invalidUploadId:
        return "400";
      case SupabaseErrorCode.keyAlreadyExists:
        return "409";
      case SupabaseErrorCode.bucketAlreadyExists:
        return "409";
      case SupabaseErrorCode.databaseTimeout:
        return "504";
      case SupabaseErrorCode.invalidSignature:
        return "403";
      case SupabaseErrorCode.signatureDoesNotMatch:
        return "403";
      case SupabaseErrorCode.accessDenied:
        return "403";
      case SupabaseErrorCode.resourceLocked:
        return "423";
      case SupabaseErrorCode.databaseError:
        return "500";
      case SupabaseErrorCode.missingContentLength:
        return "411";
      case SupabaseErrorCode.missingParameter:
        return "400";
      case SupabaseErrorCode.invalidUploadSignature:
        return "403";
      case SupabaseErrorCode.lockTimeout:
        return "423";
      case SupabaseErrorCode.s3Error:
        return "-";
      case SupabaseErrorCode.s3InvalidAccessKeyId:
        return "403";
      case SupabaseErrorCode.s3MaximumCredentialsLimit:
        return "400";
      case SupabaseErrorCode.invalidChecksum:
        return "400";
      case SupabaseErrorCode.missingPart:
        return "400";
      case SupabaseErrorCode.slowDown:
        return "503";
      default:
        return "unknown";
    }
  }

  static SupabaseErrorCode fromCode(String errorCode) {
    for (var error in SupabaseErrorCode.values) {
      if (error.code == errorCode) return error;
    }
    return SupabaseErrorCode.unknown;
  }
}
