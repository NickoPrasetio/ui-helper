//
//  notification_center.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'dart:async';

class NotificationCenter {
  final _controller = StreamController<NotificationEvent>.broadcast();

  // Singleton pattern
  NotificationCenter._privateConstructor();
  static final NotificationCenter instance = NotificationCenter._privateConstructor();

  // Stream to listen for notifications
  Stream<NotificationEvent> get stream => _controller.stream;

  // Method to post a generic notification
  void post(NotificationType type, {dynamic userInfo}) {
    _controller.add(NotificationEvent(type, userInfo: userInfo));
  }
}

enum NotificationType {
  updateFormObject,
  updateFormSection,
  updateFormRow,
}

class NotificationEvent {
  final NotificationType type;
  final dynamic userInfo;

  NotificationEvent(this.type, {this.userInfo});
}
