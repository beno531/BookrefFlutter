import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeNavigationOnMain extends NavigationEvent {}

class ChangeNavigationOnSub extends NavigationEvent {}
