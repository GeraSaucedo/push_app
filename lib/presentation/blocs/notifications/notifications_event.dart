part of 'notifications_bloc.dart';

abstract class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationStatusChange extends NotificationsEvent {
  final AuthorizationStatus status;
  NotificationStatusChange(this.status);
}

class NotificationReceived extends NotificationsEvent {
  final PushMessage pushMessage;
  NotificationReceived(this.pushMessage);
}
