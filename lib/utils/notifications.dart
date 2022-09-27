import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createPlantFoodNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'pill_reminder',
      title: 'Take your pill ',
      body: 'Florist at 123 Main St. has 2 in stock.',
    ),
  );
}
