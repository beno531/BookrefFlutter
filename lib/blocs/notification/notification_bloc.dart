import 'package:bloc/bloc.dart';
import 'package:bookref/blocs/notification/notification_event.dart';
import 'package:bookref/blocs/notification/notification_state.dart';
import 'package:flutter/material.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationIdle());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is PushNotification) {
      yield* _mapPushNotificationToState(event);
    }
  }

  Stream<NotificationState> _mapPushNotificationToState(
      PushNotification event) async* {
    yield NotificationPushed(
        status: event.status, title: event.title, message: event.message);
    yield NotificationIdle();
  }
}
