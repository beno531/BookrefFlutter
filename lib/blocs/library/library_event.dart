import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

abstract class LibraryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadLibraryItems extends LibraryEvent {}
