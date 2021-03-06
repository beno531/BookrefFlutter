import 'package:bookref/Models/book.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigationOnMain extends NavigationState {}

class NavigationOnSub extends NavigationState {}
