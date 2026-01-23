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
  required AppException exception,
}) {
  switch (exception) {
    ///
    /// AUTH
    ///
    case AppException.failed_auth_via_facebook:
      return context.tr(AppText.failed_auth_via_facebook);
    case AppException.failed_auth_via_github:
      return context.tr(AppText.failed_auth_via_github);
    case AppException.failed_auth_via_google:
      return context.tr(AppText.failed_auth_via_google);
    case AppException.failed_auth_via_login_password:
      return context.tr(AppText.failed_auth_via_login_password);
    case AppException.failed_register_user:
      return context.tr(AppText.failed_register_user);
    case AppException.failed_verify_email:
      return context.tr(AppText.failed_verify_email);
    case AppException.failed_recovery_password_email:
      return context.tr(AppText.failed_recovery_password_email);
    case AppException.account_unverified:
      return context.tr(AppText.account_unverified);
    case AppException.account_verified:
      return context.tr(AppText.account_verified);
    case AppException.sended_verify_email:
      return context.tr(AppText.sended_verify_email);

    case AppException.invalid_email:
      return context.tr(AppText.invalid_email);
    case AppException.user_disabled:
      return context.tr(AppText.user_disabled);
    case AppException.user_not_found:
      return context.tr(AppText.user_not_found);
    case AppException.wrong_password:
      return context.tr(AppText.wrong_password);
    case AppException.too_many_requests:
      return context.tr(AppText.too_many_requests);
    case AppException.user_token_expired:
      return context.tr(AppText.user_token_expired);
    case AppException.network_request_failed:
      return context.tr(AppText.network_request_failed);
    case AppException.invalid_credential:
      return context.tr(AppText.invalid_credential);
    case AppException.operation_not_allowed:
      return context.tr(AppText.operation_not_allowed);
    case AppException.account_exists_with_different_credential:
      return context.tr(AppText.account_exists_with_different_credential);
    case AppException.invalid_verification_code:
      return context.tr(AppText.invalid_verification_code);
    case AppException.invalid_verification_id:
      return context.tr(AppText.invalid_verification_id);
    case AppException.email_already_in_use:
      return context.tr(AppText.email_already_in_use);
    case AppException.weak_password:
      return context.tr(AppText.weak_password);
    case AppException.auth_invalid_email:
      return context.tr(AppText.auth_invalid_email);
    case AppException.auth_missing_android_pkg_name:
      return context.tr(AppText.auth_missing_android_pkg_name);
    case AppException.auth_missing_continue_uri:
      return context.tr(AppText.auth_missing_continue_uri);
    case AppException.auth_missing_ios_bundle_id:
      return context.tr(AppText.auth_missing_ios_bundle_id);
    case AppException.auth_user_not_found:
      return context.tr(AppText.auth_user_not_found);

    ///
    /// COMMON CASES
    ///
    case AppException.empty_case:
      return context.tr(AppText.empty_case);
    case AppException.password_does_not_matched:
      return context.tr(AppText.password_does_not_matched);
    case AppException.balance_not_enought:
      return context.tr(AppText.balance_not_enought);
    case AppException.invalid_response:
      return context.tr(AppText.invalid_response);
    case AppException.ultra_sound_unpicked:
      return context.tr(AppText.ultra_sound_unpicked);
    case AppException.failed_to_save_image_byte_to_gallery:
      return context.tr(AppText.failed_to_save_image_byte_to_gallery);

    // DEFAULT
    default:
      return 'An unexpected error occurred. Please try again.';
  }
}
