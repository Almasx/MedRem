import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:lark/utils/schedule.dart';

Future<void> createNotification(TimeOfDay time, int day) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'pill_channel',
      title: "Pill Reminder",
      body: "It's time to take a pill",
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Pill Taken',
      )
    ],
    schedule: NotificationCalendar(
      day: day,
      hour: time.hour,
      minute: time.minute,
      second: 0,
      millisecond: 0,
    ),
  );
}
