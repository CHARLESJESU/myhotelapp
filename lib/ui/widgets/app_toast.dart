import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// App toast utility class for showing toast notifications.
/// Uses the toastification package for beautiful toast messages.
///
/// Usage:
/// ```dart
/// AppToast.success(context, title: 'Success', description: 'Operation completed');
/// AppToast.error(context, title: 'Error', description: 'Something went wrong');
/// AppToast.warning(context, title: 'Warning', description: 'Please check your input');
/// ```
class AppToast {
  AppToast._(); // Private constructor to prevent instantiation

  static const Duration _defaultDuration = Duration(seconds: 3);
  static const Duration _longDuration = Duration(seconds: 5);

  /// Show a success toast
  static ToastificationItem success(
    BuildContext context, {
    required String title,
    String? description,
    Duration? duration,
    Alignment? alignment,
    bool showProgressBar = true,
    bool showCloseButton = true,
  }) {
    return toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      description: description != null
          ? Text(
              description,
              style: const TextStyle(fontSize: 13),
            )
          : null,
      alignment: alignment ?? Alignment.topRight,
      autoCloseDuration: duration ?? _defaultDuration,
      showProgressBar: showProgressBar,
      closeButtonShowType: showCloseButton
          ? CloseButtonShowType.always
          : CloseButtonShowType.none,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
    );
  }

  /// Show an error/failed toast
  static ToastificationItem error(
    BuildContext context, {
    required String title,
    String? description,
    Duration? duration,
    Alignment? alignment,
    bool showProgressBar = true,
    bool showCloseButton = true,
  }) {
    return toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      description: description != null
          ? Text(
              description,
              style: const TextStyle(fontSize: 13),
            )
          : null,
      alignment: alignment ?? Alignment.topRight,
      autoCloseDuration: duration ?? _longDuration,
      showProgressBar: showProgressBar,
      closeButtonShowType: showCloseButton
          ? CloseButtonShowType.always
          : CloseButtonShowType.none,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
    );
  }

  /// Show a warning/issue toast
  static ToastificationItem warning(
    BuildContext context, {
    required String title,
    String? description,
    Duration? duration,
    Alignment? alignment,
    bool showProgressBar = true,
    bool showCloseButton = true,
  }) {
    return toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.flatColored,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      description: description != null
          ? Text(
              description,
              style: const TextStyle(fontSize: 13),
            )
          : null,
      alignment: alignment ?? Alignment.topRight,
      autoCloseDuration: duration ?? _defaultDuration,
      showProgressBar: showProgressBar,
      closeButtonShowType: showCloseButton
          ? CloseButtonShowType.always
          : CloseButtonShowType.none,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
    );
  }

  /// Dismiss all toasts
  static void dismissAll() {
    toastification.dismissAll();
  }

  /// Dismiss a specific toast by item
  static void dismiss(ToastificationItem item) {
    toastification.dismiss(item);
  }
}
