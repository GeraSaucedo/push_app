import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_app/config/local_notifications/local_notifications.dart';
import 'package:push_app/domain/entities/push_message.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling background message');
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int pushNumberId = 0;

  final Future<void> Function()? requestLocalNotificationPermissions;
  final void Function({
    required int id,
    String? title,
    String? body,
    String? data,
  })? showLocalNotification;

  NotificationsBloc(
      {this.requestLocalNotificationPermissions, this.showLocalNotification})
      : super(const NotificationsState()) {
    on<NotificationStatusChange>(_notificationStatusChange);
    on<NotificationReceived>(_onNotificationReceived);

    // Verificar estado de las notificaciones
    _initialStatusCheck();

    // Listener para notificaciones en foreground
    _onForegroundMessage();
  }

  void _notificationStatusChange(
    NotificationStatusChange event,
    Emitter<NotificationsState> emit,
  ) {
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  void _onNotificationReceived(
    NotificationReceived event,
    Emitter<NotificationsState> emit,
  ) {
    emit(state
        .copyWith(notifications: [event.pushMessage, ...state.notifications]));
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChange(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    log(token.toString());
  }

  void handleRemoteMessage(RemoteMessage message) async {
    if (message.notification == null) return;

    final notification = PushMessage(
      messageId:
          message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
          ? message.notification!.android?.imageUrl
          : message.notification!.apple?.imageUrl,
    );

    if (showLocalNotification != null) {
      showLocalNotification!(
        id: ++pushNumberId,
        body: notification.body,
        data: message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        title: notification.title,
      );
    }

    add(NotificationReceived(notification));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (requestLocalNotificationPermissions != null) {
      await requestLocalNotificationPermissions!();
    }

    add(NotificationStatusChange(settings.authorizationStatus));
  }

  PushMessage? getMessageById(String pushMessageId) {
    final exist = state.notifications
        .any((element) => element.messageId == pushMessageId);

    if (!exist) return null;

    return state.notifications
        .firstWhere((element) => element.messageId == pushMessageId);
  }
}
