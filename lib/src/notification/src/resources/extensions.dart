import 'package:flutter/material.dart';
import 'package:idea/src/notification/src/resources/arrays.dart';
import 'package:idea/src/notification/src/resources/colors.dart';

extension NotificationTypeExtension on NotificationType {
  Color color() {
    switch (this) {
      case NotificationType.success:
        return successColor;
      case NotificationType.error:
        return errorColor;
      case NotificationType.info:
        return inforColor;
      default:
        return Colors.blue;
    }
  }
}
