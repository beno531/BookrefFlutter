import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotificationIdle extends NotificationState {}

class NotificationPushed extends NotificationState {
  final Color status;
  final String title;
  final String message;

  NotificationPushed(
      {@required this.status, @required this.title, @required this.message});
}
