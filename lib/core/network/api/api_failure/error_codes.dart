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
