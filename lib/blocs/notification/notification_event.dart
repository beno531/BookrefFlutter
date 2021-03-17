import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PushNotification extends NotificationEvent {
  final Color status;
  final String title;
  final String message;

  PushNotification(
      {@required this.status, @required this.title, @required this.message});
}
