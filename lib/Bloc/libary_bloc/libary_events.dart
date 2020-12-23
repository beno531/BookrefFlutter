import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyLibaryEvent extends Equatable {
  MyLibaryEvent([List props = const []]) : super(props);
}

class LoadMyLibaryBooks extends MyLibaryEvent {
  @override
  String toString() => 'LoadMyLibary';
}
