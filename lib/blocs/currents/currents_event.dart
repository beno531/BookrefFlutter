import 'package:equatable/equatable.dart';

abstract class CurrentsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCurrentItems extends CurrentsEvent {}
