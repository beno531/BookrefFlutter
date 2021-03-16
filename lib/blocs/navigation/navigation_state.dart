import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigationOnMain extends NavigationState {
  String route;
  NavigationOnMain({@required this.route});
}

class NavigationOnSub extends NavigationState {}

class NavigationReset extends NavigationState {}
