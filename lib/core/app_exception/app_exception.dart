// ignore_for_file: constant_identifier_names

import 'package:baby_look/core/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
  /// GENERAL
  ///
  empty_case,
  password_does_not_matched,
  balance_not_enought,
  invalid_response,
  ultra_sound_unpicked,
  failed_to_save_image_byte_to_gallery,
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
      return AppText.failed_auth_via_facebook.tr();
    case AppException.failed_auth_via_github:
      return AppText.failed_auth_via_github.tr();
    case AppException.failed_auth_via_google:
      return AppText.failed_auth_via_google.tr();
    case AppException.failed_auth_via_login_password:
      return AppText.failed_auth_via_login_password.tr();
    case AppException.failed_register_user:
      return AppText.failed_register_user.tr();
    case AppException.failed_verify_email:
      return AppText.failed_verify_email.tr();
    case AppException.failed_recovery_password_email:
      return AppText.failed_recovery_password_email.tr();
    case AppException.account_unverified:
      return AppText.account_unverified.tr();
    case AppException.account_verified:
      return AppText.account_verified.tr();
    case AppException.sended_verify_email:
      return AppText.sended_verify_email.tr();

    case AppException.invalid_email:
      return AppText.invalid_email.tr();
    case AppException.user_disabled:
      return AppText.user_disabled.tr();
    case AppException.user_not_found:
      return AppText.user_not_found.tr();
    case AppException.wrong_password:
      return AppText.wrong_password.tr();
    case AppException.too_many_requests:
      return AppText.too_many_requests.tr();
    case AppException.user_token_expired:
      return AppText.user_token_expired.tr();
    case AppException.network_request_failed:
      return AppText.network_request_failed.tr();
    case AppException.invalid_credential:
      return AppText.invalid_credential.tr();
    case AppException.operation_not_allowed:
      return AppText.operation_not_allowed.tr();
    case AppException.account_exists_with_different_credential:
      return AppText.account_exists_with_different_credential.tr();
    case AppException.invalid_verification_code:
      return AppText.invalid_verification_code.tr();
    case AppException.invalid_verification_id:
      return AppText.invalid_verification_id.tr();
    case AppException.email_already_in_use:
      return AppText.email_already_in_use.tr();
    case AppException.weak_password:
      return AppText.weak_password.tr();
    case AppException.auth_invalid_email:
      return AppText.auth_invalid_email.tr();
    case AppException.auth_missing_android_pkg_name:
      return AppText.auth_missing_android_pkg_name.tr();
    case AppException.auth_missing_continue_uri:
      return AppText.auth_missing_continue_uri.tr();
    case AppException.auth_missing_ios_bundle_id:
      return AppText.auth_missing_ios_bundle_id.tr();
    case AppException.auth_user_not_found:
      return AppText.auth_user_not_found.tr();

    ///
    /// COMMON CASES
    ///
    case AppException.empty_case:
      return AppText.empty_case.tr();
    case AppException.password_does_not_matched:
      return AppText.password_does_not_matched.tr();
    case AppException.balance_not_enought:
      return AppText.balance_not_enought.tr();
    case AppException.invalid_response:
      return AppText.invalid_response.tr();
    case AppException.ultra_sound_unpicked:
      return AppText.ultra_sound_unpicked.tr();
    case AppException.failed_to_save_image_byte_to_gallery:
      return AppText.failed_to_save_image_byte_to_gallery.tr();

    // DEFAULT
    default:
      return 'An unexpected error occurred. Please try again.';
  }
}
