enum SupabaseErrorCode {
  // Sign In Errors
  invalidCredentials,
  emailNotConfirmed,
  phoneNotConfirmed,
  otpExpired,
  mfaChallengeExpired,
  reauthenticationNeeded,
  reauthenticationNotValid,
  userBanned,
  userNotFound,
  providerEmailNeedsVerification,

  // Sign Up Errors
  emailExists,
  phoneExists,
  weakPassword,
  signupDisabled,
  emailAddressInvalid,
  emailAddressNotAuthorized,
  userAlreadyExists,

  // Update Password Errors
  samePassword,

  // MFA Errors
  mfaVerificationFailed,
  mfaFactorNotFound,
  mfaTotpEnrollNotEnabled,
  mfaIpAddressMismatch,
  mfaPhoneEnrollNotEnabled,
  mfaVerifiedFactorExists,

  // Session Errors
  sessionExpired,
  sessionNotFound,
  refreshTokenNotFound,
  refreshTokenAlreadyUsed,
  noAuthorization,

  // Rate Limiting Errors
  overEmailSendRateLimit,
  overSmsSendRateLimit,
  overRequestRateLimit,

  // OAuth/SAML/SSO Errors
  oauthProviderNotSupported,
  providerDisabled,
  samlIdpNotFound,
  samlAssertionNoEmail,
  samlRelayStateExpired,

  // Postgres Errors
  syntaxError,
  permissionDenied,
  roleDoesNotExist,
  relationDoesNotExist,
  connectionFailed,
  invalidInputSyntax,
  columnDoesNotExist,
  databaseDoesNotExist,
  noPermissionForTable,
  diskFull,

  // Storage Errors
  noSuchBucket,
  noSuchKey,
  noSuchUpload,
  invalidJwt,
  invalidRequest,
  tenantNotFound,
  entityTooLarge,
  internalError,
  resourceAlreadyExists,
  invalidBucketName,
  invalidKey,
  invalidRange,
  invalidMimeType,
  invalidUploadId,
  keyAlreadyExists,
  bucketAlreadyExists,
  databaseTimeout,
  invalidSignature,
  signatureDoesNotMatch,
  accessDenied,
  resourceLocked,
  databaseError,
  missingContentLength,
  missingParameter,
  invalidUploadSignature,
  lockTimeout,
  s3Error,
  s3InvalidAccessKeyId,
  s3MaximumCredentialsLimit,
  invalidChecksum,
  missingPart,
  slowDown,

  // Other Errors
  badJson,
  badJwt,
  requestTimeout,
  unexpectedFailure,
  conflict,
  flowStateExpired,

  // Unknown Error (default fallback)
  unknown;
}
