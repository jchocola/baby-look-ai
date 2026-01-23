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
      return 'Authentication failed via Facebook. Please try again.';
    case AppException.failed_auth_via_github:
      return 'Authentication failed via GitHub. Please try again.';
    case AppException.failed_auth_via_google:
      return 'Authentication failed via Google. Please try again.';
    case AppException.failed_auth_via_login_password:
      return "Login failed. Please check your credentials and try again.";
    case AppException.failed_register_user:
      return "Registration failed. Please try again later.";
    case AppException.failed_verify_email:
      return "Email verification failed. Please try again.";
    case AppException.failed_recovery_password_email:
      return "Password recovery email failed to send. Please try again.";
    case AppException.account_unverified:
      return "Your account is not verified. Please verify your email address.";
    case AppException.account_verified:
      return "Account is already verified.";
    case AppException.sended_verify_email:
      return "Verification email has been sent to your inbox.";

    case AppException.invalid_email:
      return 'Invalid email format. Please enter a valid email address.';
    case AppException.user_disabled:
      return 'This account has been disabled. Please contact support.';
    case AppException.user_not_found:
      return 'No account found with this email. Please register first.';
    case AppException.wrong_password:
      return "Incorrect password. Please try again.";
    case AppException.too_many_requests:
      return "Too many requests. Please try again later.";
    case AppException.user_token_expired:
      return "Session expired. Please sign in again.";
    case AppException.network_request_failed:
      return "Network request failed. Please check your connection.";
    case AppException.invalid_credential:
      return "Invalid credentials. Please try again.";
    case AppException.operation_not_allowed:
      return "This operation is not allowed. Please contact support.";
    case AppException.account_exists_with_different_credential:
      return "Account exists with different credential. Please sign in using the original method.";
    case AppException.invalid_verification_code:
      return "Invalid verification code. Please try again.";
    case AppException.invalid_verification_id:
      return "Invalid verification ID. Please request a new code.";
    case AppException.email_already_in_use:
      return "This email is already in use. Please use a different email or sign in.";
    case AppException.weak_password:
      return "Password is too weak. Please use a stronger password.";
    case AppException.auth_invalid_email:
      return "Invalid email format. Please enter a valid email address.";
    case AppException.auth_missing_android_pkg_name:
      return "Missing Android package name. Please contact support.";
    case AppException.auth_missing_continue_uri:
      return "Missing continue URI. Please contact support.";
    case AppException.auth_missing_ios_bundle_id:
      return "Missing iOS bundle ID. Please contact support.";
    case AppException.auth_user_not_found:
      return "User not found. Please register first.";

    ///
    /// COMMON CASES
    ///
    case AppException.empty_case:
      return 'No data available. Please try again later.';
    case AppException.password_does_not_matched:
      return "Passwords do not match. Please re-enter both passwords.";
    case AppException.balance_not_enought:
      return "Insufficient balance. Please purchase more coins to continue.";
    case AppException.invalid_response:
      return "Invalid response received. Please try again.";
    case AppException.ultra_sound_unpicked:
      return "Please upload an ultrasound image first.";
    case AppException.failed_to_save_image_byte_to_gallery:
      return "Failed to save image to gallery. Please try again.";

    // DEFAULT
    default:
      return 'An unexpected error occurred. Please try again.';
  }
}
