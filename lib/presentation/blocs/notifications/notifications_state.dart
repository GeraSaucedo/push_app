part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.status = AuthorizationStatus.notDetermined,
    this.notifications = const [],
  });

  final AuthorizationStatus status;
  final List<PushMessage> notifications;

  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<PushMessage>? notifications,
  }) {
    return NotificationsState(
        notifications: notifications ?? this.notifications,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [status, notifications];
}
