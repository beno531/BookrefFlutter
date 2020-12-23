import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyCurrentEvent extends Equatable {
  MyCurrentEvent([List props = const []]) : super(props);
}

class LoadMyCurrentBooks extends MyCurrentEvent {
  @override
  String toString() => 'LoadMyDashboardCurrents';
}
