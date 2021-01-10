import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyLibraryEvent extends Equatable {
  MyLibraryEvent([List props = const []]) : super(props);
}

class LoadMyLibraryBooks extends MyLibraryEvent {
  @override
  String toString() => 'LoadMyLibary';
}
