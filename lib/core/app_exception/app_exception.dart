// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum AppException {
  ///
  /// AUTH
  ///
  failed_auth_via_facebook,
  failed_auth_via_github,
  failed_auth_via_google,
  failed_auth_via_login_password,
  failed_register_user,
  failed_verify_email,
  failed_recovery_password_email,
  account_unverified,
  account_verified,
  sended_verify_email,

  ///
  /// FIREBASE EXCEPTION
  ///
  invalid_email,
  user_disabled,
  user_not_found,
  wrong_password,
  too_many_requests,
  user_token_expired,
  network_request_failed,
  invalid_credential,
  operation_not_allowed,
  account_exists_with_different_credential,
  invalid_verification_code,
  invalid_verification_id,
  email_already_in_use,
  weak_password,
  auth_invalid_email,
  auth_missing_android_pkg_name,
  auth_missing_continue_uri,
  auth_missing_ios_bundle_id,
  auth_user_not_found,

  ///
  /// COMMONS CASE
  ///
  empty_case,
  password_does_not_matched,
  balance_not_enought,
  invalid_response,
}

String AppExceptionConverter(
  BuildContext context, {
  required AppException excetion,
}) {
  switch (excetion) {
    ///
    /// AUTH
    ///
    case AppException.failed_auth_via_facebook:
      return 'failed_auth_via_facebook';
    case AppException.failed_auth_via_github:
      return 'failed_auth_via_github';
    case AppException.failed_auth_via_google:
      return 'failed_auth_via_google';
    case AppException.failed_auth_via_login_password:
      return 'failed_auth_via_login_password';
    case AppException.failed_register_user:
      return "failed_register_user";
    case AppException.failed_verify_email:
      return "failed_verify_email";
    case AppException.failed_recovery_password_email:
      return "failed_recovery_password_email";
     case AppException.account_unverified:
      return "account_unverified";
       case AppException.account_verified:
      return "account_verified";  
      case AppException.sended_verify_email:
      return "sended_verify_email";    

    case AppException.invalid_email:
      return 'invalid_email';
    case AppException.user_disabled:
      return 'user_disabled';
    case AppException.user_not_found:
      return 'user_not_found';
    case AppException.wrong_password:
      return "wrong_password";
    case AppException.too_many_requests:
      return "too_many_requests";
    case AppException.user_token_expired:
      return "user_token_expired";
    case AppException.network_request_failed:
      return "network_request_failed";
    case AppException.invalid_credential:
      return "invalid_credential";
    case AppException.operation_not_allowed:
      return "operation_not_allowed";

    ///
    /// COMMONS CASES
    ///
    case AppException.empty_case:
      return 'empty_case';
    case AppException.password_does_not_matched:
      return "password_does_not_matched";
    case AppException.balance_not_enought:
      return "balance_not_enought";
    case AppException.invalid_response:
      return "invalid_response";  

    // DEFAULT
    default:
      return 'Uncatched exception';
  }
}
