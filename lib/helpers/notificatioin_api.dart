import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  
  static final _notificaions = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel Id',
        'channel Name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
    );
  }

  static Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notificaions.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );
}
