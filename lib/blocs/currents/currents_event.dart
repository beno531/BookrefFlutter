import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

abstract class CurrentsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCurrentItems extends CurrentsEvent {}
